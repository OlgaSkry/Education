1) Create new project:
    - Open cmd Terminal
    - Change dir to your projects folder
    - create project: 
    
   ```sh
    force:project:create -n education --template standard
   ```
   - change dir to education in cmd terminal
   - open New Project in Webstorm and select folder 'education'
   - modify config/project-scratch-def.json:
   
   ```sh
       {
         "orgName": "CT Education",
         "edition": "Developer",
         "language": "en_US",
         "features": [],
         "settings": {
           "orgPreferenceSettings": {
             "s1DesktopEnabled": true
           }
         }
       }
   ```
2) Login to your dev hub if you dint't logged in already (skip this step if logged before):
   ```sh
    sfdx force:auth:web:login -d -a devHubAlias
   ```
3) Create scratch org:
    ```sh
    sfdx force:org:create -f config/project-scratch-def.json -d 30 -s -a ctedu
    ```
4) Push project to Scratch org
    ```sh
    sfdx force:source:push
    ```
4) After Scratch org successfully created click 'Resolve' in the Webstorm/IntelliJ Event Log and select in 'Connection' column created Scratch Org
5) Open org for work with:
    ```sh
    sfdx force:org:open
    ```
6) Pull changes from Scratch Org to project:
    ```sh
    sfdx force:source:pull
    ```