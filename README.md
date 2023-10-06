# Extraire les données utilisateurs de Microsoft 365

- Aller sur https://entra.microsoft.com/ et se connecter avec son compte Microsoft 365
- Cliquer sur "Utilisateurs" dans le menu de gauche puis sur "Tous les utilisateurs"
- CLiquer sur "Télécharger les utilisateurs" en haut
- Nommer le fichier "users.csv" puis cliquer sur "Demander l'extraction"
- Attendre quelques minutes puis cliquer sur "Le fichier est prêt ! Cliquez ici pour télécharger" et enregistrer le fichier "users.csv" dans le dossier du projet

# Generer le fichier de l'organigramme

- Lancer le script "run.ps1" avec PowerShell comme suit :

```powershell
.\run.ps1 `
    -tenantId "TENANT_ID" `
    -clientId "CLIENT_ID" `
    -clientSecret "CLIENT_SECRET" `
    -sourceCsvFilePath "users.csv" `
    -outputCsvFilePath "output.csv"
```

- Remplacer les valeurs "TENANT_ID", "CLIENT_ID" et "CLIENT_SECRET" par les valeurs trouvées dans le fichier "secrets.txt" du projet
- Attendre quelques minutes

# Afficher l'organigramme

- Aller sur https://lucid.app/ et se connecter avec son compte Microsoft 365
- Finir de créer un compte Lucidchart si nécessaire et passer les étapes de configuration
- (Optionnel) Changer la langue en français en cliquant sur l'image de profil en haut à droite puis sur "Account Settings", "User Settings" et enfin sur "Language Settings", sélectionner "Français" puis cliquer sur "Save Changes". Cliquer sur "Documents" en haut à droite pour revenir à la page d'accueil
- Cliquer sur "Nouveau" en haut à gauche, "Lucidchart" puis sur "Document vierge"
- Cliquer sur "Importer les données" en bas à droite
- Cliquez sur "Organigramme" puis sur "Importer vos données"