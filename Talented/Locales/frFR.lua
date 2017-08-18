local L =  LibStub:GetLibrary("AceLocale-3.0"):NewLocale("Talented", "frFR", false)
if not L then return end

L["Talented - Talent Editor"] = "Talented - Editeur de talents"

L["Layout options"] = "Options d'affichage"
-- L["Options that change the visual layout of Talented."] = "Options qui modifient l'affichage de Talented."
L["Icon offset"] = "Espacement des icônes"
L["Distance between icons."] = "Espacement entre les icônes."
L["Frame scale"] = "Echelle de la fenêtre"
L["Overall scale of the Talented frame."] = "Echelle globale de la fenêtre de Talented."

-- L["Options"] = true
L["General Options for Talented."] = "Options génériques de Talented."
L["Always edit"] = "Toujours éditer"
L["Always allow templates and the current build to be modified, instead of having to Unlock them first."] = "Toujours permettre aux templates d'être modifiés, au lieu de devoir les débloquer d'abord."
L["Confirm Learning"] = "Confirmer l'apprentissage"
L["Ask for user confirmation before learning any talent."] = "Demande une confirmation du joueur avant l'apprentissage de talent."
--~ L["Don't Confirm when applying"] = "Pas de confirmation pendant l'application"
--~ L["Don't ask for user confirmation when applying full template."] = "Ne demande pas de confirmation de l'utilisateur pendant l'application d'un template complet"
L["Always try to learn talent"] = "Toujours tenter d'apprendre un talent"
L["Always call the underlying API when a user input is made, even when no talent should be learned from it."] = "Appelle toujours l'API sous-jacente lorsque l'utilisateur clique un talent, même si aucun talent ne devrait être appris de cela."
L["Talent cap"] = "Restriction des talents"
L["Restrict templates to a maximum of %d points."] = "Restreint les templates à un maximum de %d points."
L["Level restriction"] = "Niveau requis"
L["Show the required level for the template, instead of the number of points."] = "Affiche le niveau requis plutôt que le nombre de points dépensés pour un template."
--~ L["Load outdated data"] = "Charger données périmées"
--~ L["Load Talented_Data, even if outdated."] = "Charge l'addon Talented_Data, même s'il n'est pas mis à jour à la version courante."
L["Hook Inspect UI"] = "Remplacer la fenêtre d'inspection"
L["Hook the Talent Inspection UI."] = "Remplace l'onglet talent de la fenêtre d'inspection."
--L["Output URL in Chat"] = true
L["Directly outputs the URL in Chat instead of using a Dialog."] = "Mettre les URLs directement dans le chat au lieu d'utiliser une boîte de dialogue."

L["Inspected Characters"] = "Personnages inspectés"
-- L["Talent trees of inspected characters."] = true
L["Edit template"] = "Editer le template"
L["Edit talents"] = "Modifier les talents"
L["Toggle editing of the template."] = "Active l'édition du template courant."
L["Toggle editing of talents."] = "Active l'édition des talents."

-- L["Templates"] = true
-- L["Actions"] = true
L["You can edit the name of the template here. You must press the Enter key to save your changes."] = "Vous pouvez éditer le nom du template ici. Vous devez valider vos changements avec la touche Entrée."

L["Remove all talent points from this tree."] = "Vider cet arbre de ces points de talent."
-- L["%s (%d)"] = true
L["Level %d"] = "Niveau %d"
-- L["%d/%d"] = true
--~ L["Right-click to unlearn"] = "Clic-Droit pour désapprendre"
L["Effective tooltip information not available"] = "Information exacte du tooltip indisponible"
L["You have %d talent |4point:points; left"] = "Il vous reste %d |4point:points; de talents"
L["Are you sure that you want to learn \"%s (%d/%d)\" ?"] = "Êtes vous sur de vouloir apprendre \"%s (%d/%d)\" ?"

--~ L["Open the Talented options panel."] = "Ouvrir les options de Talented."

--~ L["View Current Spec"] = "Voir la spécialisation actuelle"
L["View the Current spec in the Talented frame."] = "Afficher la spécialisation actuelle dans la fenêtre de Talented."
--~ L["View Alternate Spec"] = "Voir la spécialisation alternative"
L["Switch to this Spec"] = "Basculer vers cette spécialisation"
L["View Pet Spec"] = "Voir la spécialisation du familier"

L["New Template"] = "Nouveau Template"
L["Empty"] = "Vide"

L["Apply template"] = "Appliquer le template"
L["Copy template"] = "Copier le template"
L["Delete template"] = "Supprimer le template"
L["Set as target"] = "Définir comme cible"
L["Clear target"] = "Retirer la cible"

L["Sorry, I can't apply this template because you don't have enough talent points available (need %d)!"] = "Désolé, je ne peux pas appliquer ce template car vous n'avez pas assez de points de talents à votre disposition (besoin de %d)."
L["Sorry, I can't apply this template because it doesn't match your pet's class!"] = "Désolé, je ne peux pas appliquer ce template car il ne correspond pas à la classe de votre animal de compagnie !"
L["Sorry, I can't apply this template because it doesn't match your class!"] = "Désolé, je ne peux pas appliquer ce template car il ne correspond pas à votre classe !"
--~ L["Talented cannot perform the required action because it does not have the required talent data available for class %s. You should inspect someone of this class."] = "Talented ne peux pas effectuer l'action demandée car il n'a pas les informations de talents nécéssaire pour la classe %s. Vous devriez inspecter quelqu'un de cette classe."
--~ L["You must install the Talented_Data helper addon for this action to work."] = "Vous devez installer l'addon supplémentaire Talented_Data pour que cette action fonctionne."
--~ L["You can download it from http://files.wowace.com/ ."] = "Vous pouvez le télécharger de http://files.wowace.com/ ."

L["Inspection of %s"] = "Inspection de %s"
L["Select %s"] = "Sélectionner %s"
L["Copy of %s"] = "Copie de %s"
L["Target: %s"] = "Cible : %s"
L["Imported"] = "Importé"

L["Please wait while I set your talents..."] = "Veuillez patienter pendant que je définis vos talents..."
L["The given template is not a valid one! (%s)"] = "Le template indiqué n'est pas valide ! (%s)"
L["Error while applying talents! Not enough talent points!"] = "Erreur pendant l'application des talents ! Vous n'avez plus de points de talents !"
L["Error while applying talents! some of the request talents were not set!"] = "Erreur pendant l'application des talents ! quelques-uns des talents n'ont pas été appliqués!"
L["Talent application has been cancelled. %d talent points remaining."] = "L'application des talents a été annulée. %d points de talents restants."
L["Template applied successfully, %d talent points remaining."] = "Template appliqué avec succès, %d points de talent restants."
--~ L["Talented_Data is outdated. It was created for %q, but current build is %q. Please update."] = "Talented_Data n'est pas à jour. Il a été crée pour %q, mais la version courante est %q. Veuillez mettre à jour."
--~ L["Loading outdated data. |cffff1010WARNING:|r Recent changes in talent trees might not be included in this data."] = "Chargement des données périmées. |cffff1010ATTENTION :|r Des changements récents dans les arbres de talents peuvent ne pas être inclus dans ces données."
L["\"%s\" does not appear to be a valid URL!"] = "\"%s\" ne semble pas être une URL valide !"

L["Import template ..."] = "Importer un template ..."
L["Enter the complete URL of a template from Blizzard talent calculator or wowhead."] = "Entrez l'URL complète d'un template provenant du Calculateur de talents de Blizzard ou de Wowhead."

L["Export template"] = "Exporter le template"
L["Blizzard Talent Calculator"] = "Calculateur de talent de Blizzard"
L["Wowhead Talent Calculator"] = "Calculateur de talent de Wowhead"
L["Wowdb Talent Calculator"] = "Calculateur de talent de Wowdb"
L["MMO Champion Talent Calculator"] = "Calculateur de talent de MMO Champion"
--~ L["http://www.worldofwarcraft.com/info/classes/%s/talents.html?tal=%s"] = "http://www.wow-europe.com/fr/info/basics/talents/%s/talents.html?tal=%s"
L["http://www.wowarmory.com/talent-calc.xml?%s=%s&tal=%s"] = "http://eu.wowarmory.com/talent-calc.xml?%s=%s&tal=%s"
L["http://www.wowhead.com/talent#%s"] = "http://fr.wowhead.com/talent#%s"
L["http://www.wowhead.com/petcalc#%s"] = "http://fr.wowhead.com/petcalc#%s"
L["Send to ..."] = "Envoyer à ..."
L["Enter the name of the character you want to send the template to."] = "Entrez le nom du personnage à qui vous souhaitez envoyer ce template."
L["Do you want to add the template \"%s\" that %s sent you ?"] = "Souhaitez-vous ajouter le template \"%s\", que %s vous a envoyé ?"

--~ L["Pet"] = "Familier"
L["Options ..."] = "Options ..."

L["URL:"] = "URL :"
L["Talented has detected an incompatible change in the talent information that requires an update to Talented. Talented will now Disable itself and reload the user interface so that you can use the default interface."] = true
L["WARNING: Talented has detected that its talent data is outdated. Talented will work fine for your class for this session but may have issue with other classes. You should update Talented if you can."] = true
L["View glyphs of alternate Spec"] = "Voir les glyphes de la spécialisation alternative"
--L[" (alt)"] = true
L["The following templates are no longer valid and have been removed:"] = "Les templates suivants ne sont plus valables et ont été enlevés :"
L["The template '%s' is no longer valid and has been removed."] = "Le template '%s' n'est plus valide et a été supprimé."
L["The template '%s' had inconsistencies and has been fixed. Please check it before applying."] = "Le template '%s' avait des incohérences qui ont été corrigées. Vérifiez-le avant d'appliquer."

L["Lock frame"] = "Bloquer la fenêtre"
L["Can not apply, unknown template \"%s\""] = "Ne peut pas s'appliquer, template \"%s\" inconnu"

L["Glyph frame policy on spec swap"] = "Politique de gestion de changement de spécialisation de la fenêtre de Glyphes"
L["Select the way the glyph frame handle spec swaps."] = "Choisis la façon dont la fenêtre de glyphes gère les changements de spécialisations."
L["Keep the shown spec"] = "Maintiens la spécialisation affichée"
L["Swap the shown spec"] = "Change de spécialisation"
L["Always show the active spec after a change"] = "Affiche systèmatiquement la nouvelle spécialisation"

L["General options"] = "Options génériques"
L["Glyph frame options"] = "Options de la fenêtre de glyphes"
L["Display options"] = "Options d'affichage"
L["Add bottom offset"] = "Espace au bas de la fenêtre"
L["Add some space below the talents to show the bottom information."] = "Ajoute un espace en bas de la fenêtre en dessous des talents pour afficher les informations supplémentaires."

L["Right-click to activate this spec"] = "Clic-droit pour activer cette spécialisation"

--~ L["Mode of operation."] = true

--~ -- L["Mode"] = true
--~ L["Mode of operation."] = "Mode opératoire"
--~ L["Apply the current template to your character."] = "Applique le template courant à votre personnage."
--~ L["Are you sure that you want to apply the current template's talents?"] = "Etes-vous sûr de vouloir appliquer ce template ?"
--~ L["Delete the current template."] = "Supprime le template courant."
--~ L["Are you sure that you want to delete this template?"] = "Etes-vous sûr de vouloir supprimer ce template ?"
--~ L["Import a template from Blizzard's talent calculator."] = "Importe un template du calculateur de talent de Blizzard."
--~ L["<full url of the template>"] = "URL complète du template"
--~ L["Export this template to your current chat channel."] = "Exporte le template vers la cible du chat."
--~ L["Write template link"] = "Ajoute un lien"
--~ L["Write a link to the current template in chat."] = "Ajoute un lien vers le template sur la fenêtre de chat."
--~ -- L["Template"] = true
--~ L["Create a new Template."] = "Créer un nouveau template."
--~ L["New empty template"] = "Nouveau template vide"
--~ L["Create a new template from scratch."] = "Créer un template vide."
--~ L["Copy current talent spec"] = "Copier du template courant"
--~ L["Create a new template from your current spec."] = "Créer un template à partir du template courant du personnage."
--~ L["Current template"] = "Template courant"
--~ L["Select the current template."] = "Sélectionne le template courant du personnage."
--~ L["Copy from %s"] = "Copier de %s"
--~ L["Create a new template from %s."] = "Créer un template à partir de %s"
--~ -- L["Talented - Template \"%s\" - %s :"] = true
--~ -- L["%s :"] = true
--~ -- L["_ %s"] = true
--~ -- L["_ %s (%d/%d)"] = true
--~ L["Options of Talented"] = "Options de Talented"
--~ L["Options for Talented."] = "Options de Talented"
--~ -- L["CHAT_COMMANDS"] = { "/talented" }
--~ L["Back to normal mode"] = "Retour au mode normal"
--~ L["Return to the normal talents mode."] = "Retourne à l'édition normale des talents."
--~ L["Switch to template mode"] = "Passer au mode template"
--~ L["Enter template editing mode."] = "Entre dans le mode d'édition de templates"
--~ L["Export the template."] = "Exporter le template."
--~ L["Export to chat"] = "Exporter vers le chat"
--~ L["Export as URL"] = "Exporter comme URL"
--~ L["Export to ..."] = "Envoyer à ..."
--~ L["Send the template to another Talented user."] = "Envoie le template à une autre joueur."
--~ L["<name>"] = "<nom>"
--~ L["Error while applying talents! Invalid template!"] = "Erreur pendant l'application des talents ! template invalide !"
--~ L["WoW Talent Calculator"] = "Calculateur de talent Wow"
--~ L["Export the template as a URL to the official talent calculator"] = "Exporter le template via une URL vers le calculateur de talent officiel de wow."
--~ L["Wowhead Talent Calculator"] = "Calculateur de talent wowhead"
--~ L["Export the template as a URL to the wowhead talent calculator."] = "Exporter le template via une URL vers le calculateur de talent officiel de wowhead."
--~ L["Default to edit"] = "Editer par défaut"
--~ L["Always show templates and talent in edit mode by default."] = "Affiche toujours les templates et les talents en mode d'édition par défaut."
--~ L["Set this template as the target template, so that you may use it as a guide in normal mode."] = "Définie ce template comme template cible, afin de l'utiliser comme guide en mode normal."
--~ L["Talented Links options."] = "Options des liens de Talented"
--~ L["Color Template"] = "Colorer les liens"
--~ L["Toggle the Template color on and off."] = "Active ou non la coloration des liens."
--~ L["Set Color"] = "Couleur"
--~ L["Change the color of the Template."] = "Definie la couleur à utiliser pour les liens."
--~ L["Query Talent Spec"] = "Demander ses talents"
--~ L["From Rock"] = "Venant de Rock"
--~ L["Received talent information from LibRock."] = "Arbres de talent obtenu grace à Rock"
--~ L["Query"] = "Requête"
--~ L["Request a player's talent spec."] = "Demander à un joueur son arbre de talents."
--~ L["Query group"] = "Demander au groupe"
--~ L["Request talent information for your whole group (party or raid)."] = "Demander à l'ensemble du groupe (groupe de 5 ou raid)."
--~ L["Clone selected"] = "Copier ce template"
--~ L["Make a copy of the current template."] = "Crée une copie du template en cours."
--~ L["Inspected Players"] = "Joueurs inspectés"
--~ L["Talent trees of inspected players."] = "Arbres de talent des joueurs inspectés."
