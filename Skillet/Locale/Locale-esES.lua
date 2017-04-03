--[[

Skillet: A tradeskill window replacement.
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

local L = AceLibrary("AceLocale-2.2"):new("Skillet")

L:RegisterTranslations("esES", function() return {
    ["Skillet Trade Skills"] 			= "Skillet - Habilidades de Comercio", -- default message
    ["Create"] 				 	= "Crear",
    ["Queue All"]				= "Encolar Todo",
    ["Create All"]				= "Crear Todo",
    ["Create"]					= "Crear",
    ["Queue"]					= "Encolar",
    ["Enchant"]					= "Encantar",
    ["Rescan"]                      		= "Rescanear",
    ["Number of items to queue/create"]		= "Número de elementos a encolar/crear",
    ["buyable"]					= "vendible",
    ["reagents in inventory"]			= "reactivos en el inventario",
    ["bank"]					= "banco", -- "reagents in bank"
    ["alts"]					= "alts", -- "reagents on alts"
    ["can be created from reagents in your inventory"] 		= "puede ser creado con los reactivos de tu inventario",
    ["can be created from reagents in your inventory and bank"] = "puede ser creado con los reactivos de tu inventario y banco",
    ["can be created from reagents on all characters"] 		= "puede ser creado con los reactivos de todos tus caracteres",
    ["Scanning tradeskill"]			= "Escaneando Habilidades de Comercio",
    ["Scan completed"]				= "Escaneo completado",
    ["Filter"]					= "Filtro",
    ["Hide uncraftable"]			= "Ocultar Imposibles de Crear",
    ["Hide trivial"]				= "Ocultar Triviales",
    ["Options"]					= "Opciones",
    ["Notes"]					= "Notas",
    ["Purchased"]				= "Comprado",
    ["Total spent"]				= "Total gastado",
    ["This merchant sells reagents you need!"]  = "¡Este mercader vende los reactivos que necesitas!",
    ["Buy Reagents"]				= "Comprar Reactivos",
    ["click here to add a note"]		= "Click aquí para añadir una nota",
    ["not yet cached"]				= "aún no en caché",

    -- Options
    ["About"]				= "Acerca de",
    ["ABOUTDESC"]			= "Imprime información acerca de Skillet",
    ["Config"]				= "Configuración",
    ["CONFIGDESC"]			= "Abre una ventana de configuración para Skillet",
    ["Shopping List"]			= "Lista de la Compra",
    ["SHOPPINGLISTDESC"]		= "Mostrar la Lista de la Compra",

    ["Features"]			= "Características",
    ["FEATURESDESC"]			= "Comportamiento opcional que puede activarse y desactivarse",
    ["VENDORBUYBUTTONNAME"]		= "Mostrar botón comprar reactivos en proveedores",
    ["VENDORBUYBUTTONDESC"]		= "Muestra un botón cuando hable con los vendedores que le permitirá ver los reactivos necesarios para todas las recetas en cola.",
    ["VENDORAUTOBUYNAME"]		= "Automáticamente comprar los reactivos",
    ["VENDORAUTOBUYDESC"]		= "Si tiene recetas en cola y habla con un vendedor que vende algo necesario para las recetas, se adquiere automáticamente.",
    ["SHOWITEMNOTESTOOLTIPNAME"]	= "Añadir notas usuario especificadas al tooltip",
    ["SHOWITEMNOTESTOOLTIPDESC"]	= "Añadir notas proporcionadas para un elemento al tooltip para ese elemento",
    ["SHOWDETAILEDRECIPETOOLTIPNAME"]	= "Mostrar tooltip detallado para recipientes",
    ["SHOWDETAILEDRECIPETOOLTIPDESC"]	= "Mostrar un tooltip detallado cuando se cierne sobre recetas en el panel izquierdo",
    ["LINKCRAFTABLEREAGENTSNAME"]	= "Hacer reactivos clickeables",
    ["LINKCRAFTABLEREAGENTSDESC"]	= "Si puedes crear un reactivo necesario para la receta actual, clickenado el reactivo le llevará a su receta.",
    ["QUEUECRAFTABLEREAGENTSNAME"]	= "Encolar reactivos fabricables",
    ["QUEUECRAFTABLEREAGENTSDESC"]	= "Si puedes crear un reactivo necesario para la receta actual, y no tienes suficientes, entonces estos reactivos serán añadidos a la cola",
    ["DISPLAYSHOPPINGLISTATBANKNAME"]	= "Mostrar Lista de la Compra en los Bancos",
    ["DISPLAYSHOPPINGLISTATBANKDESC"]	= "Mostrar una Lista de la Compra de los elementos que son necesarios para fabricar recetas encoladas pero que no están en tus bolsas",
    ["DISPLAYSGOPPINGLISTATAUCTIONNAME"]= "Mostrar Lista de la Compra en la Subasta",
    ["DISPLAYSGOPPINGLISTATAUCTIONDESC"]= "Mostrar una Lista de la Compra de los elementos que son necesarios para fabricar recetas encoladas pero que no están en tus bolsas",

    ["Appearance"]		= "Apariencia",
    ["APPEARANCEDESC"]		= "Opciones que controlan como Skillet es mostrado",
    ["DISPLAYREQUIREDLEVELNAME"]= "Mostrar nivel necesario",
    ["DISPLAYREQUIREDLEVELDESC"]= "Si el elemento fabricado requiere un nivel mínimo para utilizar, este nivel será mostrado con la receta",
    ["Transparency"]		= "Transparencia",
    ["TRANSPARAENCYDESC"]	= "Transparencia de la ventana principal de las Habilidades de Comercio",

    -- New in version 1.6
    ["Shopping List"]               = "Lista Compra",
    ["Retrieve"]                    = "Recuperar",
    ["Include alts"]                = "Incluir Alts",

    -- New in vesrsion 1.9
    ["Start"]                       = "Iniciar",
    ["Pause"]                       = "Pausar",
    ["Clear"]                       = "Limpiar",
    ["None"]                        = "Ninguno",
    ["By Name"]                     = "Por Nombre",
    ["By Difficulty"]               = "Por Dificultad",
    ["By Level"]                    = "Por Nivel",
    ["Scale"]                       = "Escala",
    ["SCALEDESC"]                   = "Escala de la venta de Habilidades de Comercio (predeterminado 1.0)",
    ["Could not find bag space for"] = "No puedo encontrar un espacio en la bolsa para",
    ["SORTASC"]                     = "Ordenar la lista de recetas del mayor (arriba) al menor (abajo)",
    ["SORTDESC"]                    = "Ordenar la lista de recetas del menor (arriba) al mayor (abajo)",
    ["By Quality"]                  = "Por Calidad",

    -- New in version 1.10
    ["Inventory"]                   = "Inventario",
    ["INVENTORYDESC"]               = "Información del Inventario",
    ["Supported Addons"]            = "Addons Soportados",
    ["Selected Addon"]              = "Addon Seleccionado",
    ["Library"]                     = "Librería",
    ["SUPPORTEDADDONSDESC"]         = "Addons soportados que pueden o son usados para rastrear el inventario",
    ["SHOWBANKALTCOUNTSNAME"]       = "Incluir contenido del banco y caracter alt",
    ["SHOWBANKALTCOUNTSDESC"]       = "Cuando se calcula y se muestra contador de elementos fabricables, incluir elementos de tu banco y de tus otros caracteres.",
    ["ENHANCHEDRECIPEDISPLAYNAME"]  = "Mostrar la dificultad de la receta como texto",
    ["ENHANCHEDRECIPEDISPLAYDESC"]  = "Cuando activo, nombres de las recetas tendrán uno o más caracteres '+' añadido a su nombre para indicar la dificultad de la receta.",
    ["SHOWCRAFTCOUNTSNAME"]         = "Mostrar Contador Fabricación",
    ["SHOWCRAFTCOUNTSDESC"]         = "Mostrar el número de veces que se puede elaborar una receta, no el número total de elementos elaborables",


    -- New in version 1.11
    ["Crafted By"]                  = "Crafted by",
} end)
