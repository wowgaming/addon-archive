#!/usr/bin/env ruby -w

# == Synopsis
#   This is a small cmdline program to convert a WoW saved variable file to Yaml
#   used to generaed user_data for GatherMate_Data import .
# == Usage
#   gmsv2yaml -s data_source.lua -i [1..x] [-m]
#
# == Options
#   -h, --help    Displays help message
#   -s, --source  Indicate the Source Saved Variables
#   -i, --id      Indicate the id of the file
#   -m, --merge   Merge distinct yaml files in supplied directory
#
# == Author
#   Sal Scotto
#
# == Requirements
#   This application depends on rubyluabridge
#   on RubyForge
#

require 'rubygems'
require 'rdoc/usage'
require 'rubyluabridge'
require 'yaml'
require 'getoptlong'

class GatherMateToYaml
  def initialize()
    @src = nil
    @id = -1
    opts = GetoptLong.new(
      ['--help','-h', GetoptLong::NO_ARGUMENT],
      ['--source','-s', GetoptLong::REQUIRED_ARGUMENT],
      ['--id','-i', GetoptLong::REQUIRED_ARGUMENT],
      ['--merge','-m', GetoptLong::OPTIONAL_ARGUMENT]
    )
    opts.each do |opt, arg|
      case opt
        when '--help'
          RDoc::usage
        when '--source'
          @src = arg
        when '--id'
          @id = arg.to_i
        when '--merge'
          @merge = arg
        end
    end
    if @src.nil? or @id < 0
      RDoc::usage
    end
  end
  def convert(table,file)
    rhash = Hash.new
    table.each do |k,v|
      k = k.to_i
      fkey = k
      m = v.to_hash
      fval = Hash.new
      m.each do |mk,mv|
        fval[mk.to_i] = mv.to_i
      end
      if fkey != 0
        rhash[fkey]=fval
      end
    end
    puts "Generating #{file} ..."
    File.open(file,'w') do |out|
      YAML.dump(rhash,out )
    end
  end
  def merge()
    files = Dir.entries(@merge)
    gas_hash = Hash.new
    fish_hash = Hash.new
    files.each do |file|
      if file =~ /user_gas_\d+\.yaml/
        puts "Found #{file}"
        m = YAML.load_file("#{@merge}/#{file}")
        gas_hash.merge!(m){|key, oldval, newval| 
          oldval.merge!(newval)
        }
      end
      if file =~ /user_fish_\d+\.yaml/
        puts "Found #{file}"
        m = YAML.load_file("#{@merge}/#{file}")
        fish_hash.merge!(m){|key, oldval, newval| 
          oldval.merge!(newval)
        }
      end      
    end
    # save the results
    puts "Saving merged gas .."
    File.open("#{@merge}/user_gas.yaml",'w') do |out|
      YAML.dump(gas_hash,out )
    end
    # save the results
    puts "Saving merged fish .."
    File.open("#{@merge}/user_fish.yaml",'w') do |out|
      YAML.dump(fish_hash,out )
    end
  end
  def process()
    if @merge then
      merge()
      exit
    end
    lua = Lua::State.new
    data = IO.read(@src)
    lua.eval(data)
    begin
      lua.__globals.each do |k,v|
        case k
          when 'GatherMateFishDB'
            convert(v,"user_fish_#{@id}.yaml")
          when 'GatherMateGasDB' 
            convert(v,"user_gas_#{@id}.yaml")
        end
      end
    rescue Exception => e
      puts "Error : #{e}"
    end
  end
end

l = GatherMateToYaml.new
l.process