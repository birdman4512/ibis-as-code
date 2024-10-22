# Ibis As Code #

DFIR detection by code. A repository of code based detection for use within DFIR2Go

### What is this repository for? ###

* Quick summary
* Version
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

This repo is intented to work alongside DFIR2Go. It should be cloned into a folder named ibis-as-code at the same folder level as DFIR2Go. The DFIR2Go stack will automatically map into this set of folders.

Before starting, ensure you have created an App password that has read access to the repos.  

1. Clone repo at the same level as DFIR2Go
   ```sh
   git clone [[ibis-as-code URL]] 
   ```

2. Enjoy a coffee / tea / hot chocolate / mineral water

### Folder Structure ###

It is important that this repo maintains the correct folder structure as it is mapped into by DFIR2Go. Here is an overview of what to place into each folder.

#### Jupyter ####

Files contained within this folder should be Jupyter notebooks or python files that are written and maintained in VS Code Server. 

#### Opensearch ####

For files exported (or to be imported) into OpenSearch. This can include

* Index Patterns
* Visualisations
* Dashboards
* Notebooks

#### Velociraptor ####

For files mapped to Velociraptor. 
This folder is likely to contain subfolders for different types of code within Velociraptor. 

* artifact_definitions - Contains custom Velociraptor Artifacts. 

#### Other Folders ####

Data can be stored in other folders (such as a sigma folder, or similar), however when creating new folders, please keep in mind how they may need to interact with DFIR2Go. If in doubt, have a chat to the contacts below.

### Managing Code ###

The entire folder can be managed via code-server as it comes pre-configured with GIT installed. 


### Who do I talk to? ###

* Dean B