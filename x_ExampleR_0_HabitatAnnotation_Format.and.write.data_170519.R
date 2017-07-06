###### Importing Habitat Annotation points from TransectMeasure (Stereo)----
### Written by Tim Langlois 
### Any errors are due to Tim Langlois
### Please forward any updates and improvements to timothy.langlois@uwa.edu.au or make a pull request on the GitHub


### Designed to take direct output from an TransectMeasure project. 

### objective is to 
# 1 Import and combine data from .txt file data collected in a 4 x 5 grid of CATAMI and relief codes
  # 2 Summarise cover of benthos and score of complexity as point scores 

# Set directories----
rm(list=ls()) 

data.dir=("~/ownCloud/GitHub_Example") 
habitat.dir=paste(data.dir,"/Habitat",sep="/") 

## Set Campaign ID (Study name) -----
ID <- "Example"

# Load required libraries ----
detach("package:plyr", unload=TRUE)#will error - no worries
library(tidyr)
citation("tidyr")
library(dplyr)
citation("dplyr")
options(dplyr.width = Inf) #enables head() to display all coloums
library(ggplot2)
library(stringr)
library("readr") # allows you to save final data as text file


# Load and format habitat annotation data from TransectMeasure----
setwd(habitat.dir)
dir()

data<-paste(ID,"Dot Point Measurements.txt",sep="_")

hab<-read.delim(data,header=T,skip=4,stringsAsFactors=FALSE)%>%
  setNames(tolower(names(.)))%>%
  mutate(Sample= str_replace_all(.$filename,c(".jpg" = "","_" = "", ".JPG" = "")))%>% 
  select(-c(filename,frame,time..mins.,date,location,site..,transect..,latitude,longitude,rugosity,depth,collector,fishing.status,spare,spare.1,code,x, x.1,radius..))

head(hab)

# Check format -----
unique(hab$Sample)
sort(table(hab$Sample),decreasing=TRUE) ### Test to see how many times Sample is used - each should be 20

# Check to see if Sample names used in habitat data matches metadata file ----
setwd(data.dir)
dir()

metadata<-read_tsv(paste(ID,'Metadata.txt',sep="_"))

test<-anti_join(hab,metadata,by='Sample')
test2<-anti_join(metadata,hab,by='Sample')

head(test) # All rows in hab that don't have a match in metadata (most important)
head(test2) # All rows in metadata that don't have a match in hab

# Create %fov----
fov.point.score<-hab%>%
  select(-c(broad,relief,morphology, type))%>% 
  filter(!fieldofview=="")%>%
  filter(!is.na(fieldofview))%>%
  mutate(fieldofview=paste("fieldofview",fieldofview,sep = "."))%>%
  mutate(count=1)%>%
  spread(key=fieldofview,value=count, fill=0)%>%
  select(-c(image.row,image.col))%>%
  group_by(Sample)%>%
  summarise_each(funs(sum))
head(fov.point.score,2)
unique(fov.point.score$Sample)

# Create relief----
relief.point.score<-hab%>%
  filter(!broad%in%c("Open Water"))%>%
  filter(!relief%in%c("Unknown",""))%>%
  select(-c(broad,morphology,type,fieldofview))%>% 
  mutate(count=1)%>%
  mutate(relief=str_replace(relief,".",""))%>% # removes first fullstop
  mutate(relief=paste("Relief:",relief,sep = " "))%>% # Adds prefix 'Relief:' 
  spread(key=relief,value=count, fill=0)%>%
  select(-c(image.row,image.col))%>%
  group_by(Sample)%>%
  summarise_each(funs(sum))
head(relief.point.score,2)

# CREATE catami_broad------
broad.point.score<-hab%>%
  select(-c(fieldofview,morphology,type,relief))%>% 
  mutate(broad=ifelse(broad=="Octocoral/Black","Octocoral.Black",ifelse(broad=="Stony corals","Stony.corals",ifelse(broad=="Open Water","Open.Water",broad))))%>%#correct bad names
  mutate(broad=ifelse(broad=="1_Hard Corals","Hard Corals",broad))%>% # For old attribute file
  mutate(broad=ifelse(broad=="2_Macroalgae","Macroalgae",broad))%>%
  mutate(broad=ifelse(broad=="3_Consoldated Substrate","Consolidated",broad))%>% ## Spelling fix
  mutate(broad=ifelse(broad=="3_Consolidated Substrate","Consolidated",broad))%>%
  mutate(broad=ifelse(broad=="4_Unconsolidated Substrate","Unconsolidated",broad))%>%## Spelling fix
  mutate(broad=ifelse(broad=="4_Unconsoldated Substrate","Unconsolidated",broad))%>%
  filter(!broad=="")%>%
  filter(!is.na(broad))%>%
  filter(!broad=="Unknown")%>%
  filter(!broad=="Open.Water")%>%
  mutate(broad=paste("Biota:",broad,sep = " "))%>%
  mutate(count=1)%>%
  group_by(Sample)%>%
  spread(key=broad,value=count,fill=0)%>%
  select(-c(image.row,image.col))%>%
  group_by(Sample)%>%
  summarise_each(funs(sum))
head(broad.point.score)

# CREATE catami_broad_morphology_type-----
#Have to do this in two stages to allow points with morphology only
broad_morphology_only<-hab%>%
  select(-c(fieldofview,relief))%>%
  filter(!morphology=="")%>%
  filter(!is.na(morphology))%>%
  filter(!morphology=="Unknown")%>%
  filter(is.na(type)|type=="")%>%
  filter(!type=="No biota")%>%
  mutate(morphology=ifelse(morphology=="1_Small mixed other","Small mixed other",morphology))%>%
  mutate(broad=ifelse(broad=="1_Small mixed other","Small mixed other",broad))%>%
  mutate(broad=ifelse(broad=="2_Macroalgae","Macroalgae",broad))%>%
  mutate(broad=ifelse(broad=="4_Unconsoldated Substrate","Unconsolidated",broad))%>%
  mutate(broad=ifelse(broad=="3_Consoldated Substrate","Consolidated",broad))%>%
  mutate(catami_broad_morphology_type=paste("Biota: ",broad,": ",morphology,sep = ""))
head(broad_morphology_only,2)
unique(broad_morphology_only$morphology)
unique(broad_morphology_only$broad)

unique(broad_morphology_only$type)

broad_morphology_with_type<-hab%>%
  select(-c(fieldofview,relief))%>%
  filter(!morphology=="")%>%
  filter(!is.na(morphology))%>%
  filter(!morphology=="Unknown")%>%
  filter(!type=="")%>%
  filter(!is.na(type))%>%
  filter(!type=="No biota")%>%
  mutate(broad=ifelse(broad=="2_Macroalgae","Macroalgae",broad))%>%
  mutate(broad=ifelse(broad=="1_Hard Corals","Hard Corals",broad))%>%
  mutate(broad=ifelse(broad=="3_Consoldated Substrate","Consolidated",broad))%>%
  mutate(morphology=ifelse(morphology=="2_Erect branching","Erect branching",morphology))%>%
  mutate(morphology=ifelse(morphology=="5_Foliose / plate","Foliose / plate",morphology))%>%
  mutate(morphology=ifelse(morphology=="2_Branching","Branching",morphology))%>%
  mutate(morphology=ifelse(morphology=="2_Erect coarse branching","Erect coarse branching",morphology))%>%
  mutate(morphology=ifelse(morphology=="4_Encrusting","Encrusting",morphology))%>%
  mutate(morphology=ifelse(morphology=="3_Tabulate","Tabulate",morphology))%>%
  mutate(morphology=ifelse(morphology=="1_Small mixed other","Small mixed other",morphology))%>%
  mutate(catami_broad_morphology_type=paste("Biota: ",broad,": ",morphology,": ",type,sep = ""))
head(broad_morphology_with_type,2)

unique(broad_morphology_with_type$broad)
unique(broad_morphology_with_type$morphology)

broad_morphology_type.point.score<-bind_rows(broad_morphology_only,broad_morphology_with_type)%>%
  mutate(count=1)%>%
  group_by(Sample)%>%
  spread(key=catami_broad_morphology_type,value=count,fill=0)%>%
  select(-c(image.row,image.col,broad,morphology,type))%>%
  group_by(Sample)%>%
  summarise_each(funs(sum))
head(broad_morphology_type.point.score,2)


# Write final habitat data----
# join starting with relief - as this is most likely to have the most samples with habitat data
setwd(data.dir)
dir()

habitat.point.score<-relief.point.score%>%
  left_join(fov.point.score,by="Sample")%>%
  left_join(broad.point.score,by="Sample")%>% #use this line if you broad.point.score
  #left_join(broad_morphology_type.point.score,by="Sample")%>% #use this line if you have morphology_type data (instead of above)
  write_tsv(paste(ID,"Habitat.point.score.txt",sep="_"))

head(habitat.point.score,2)
