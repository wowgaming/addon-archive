Alternate fonts aren't included. You may get/download them seperately.

QuestHelper uses 3 styles:
  
  sans  - Used for menus and the chat frame.
  serif - Used for the map button.
  fancy - Used for menu titles.
  
  If serif is missing, it will fallback to the sans font if it exists.
  If fancy is missing, it will fallback to the serif or sans font if it exists.
  
Translations may specify alternate fonts to use, as a list of strings seperated by semicolons. Example:
  
  QuestHelper_SubstituteFonts.xxYY = {sans = "Interface\\<some font>;AnotherFont;AndAnother", serif = "...", fancy = "..."}
  
The first font in the list that exists will be used.

Alternatively, fonts can be placed here in the format: <locale>_<style>.tff

As an example, placing a font in this folder named 'enUS_sans.ttf' will cause that font to be used for all English text QuestHelper displays. This includes the chatframe QuestHelper writes output to.
