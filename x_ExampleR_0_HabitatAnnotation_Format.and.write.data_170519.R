###### Importing Habitat Annotation points from TransectMeasure (Stereo)----
### Written by Tim Langlois 
### Any errors are due to Tim Langlois
### Please forward any updates and improvements to timothy.langlois@uwa.edu.au or make a pull request on the GitHub


### Designed to take direct output from an TransectMeasure project. 

### objective is to 
# 1 Import and combine data from .txt file data collected in a 4 x 5 grid of CATAMI and relief codes
# 2 Summarise cover of benthos and score of complexity as point scores 

### File Structure for this script to work (without changes) needs to be:
# GoogleDrive > GlobalArchive_Uploads > Custodian > Projects > Campaign ID 
# Within each Campaign ID is the txt files and a folder called TMObs, with TMObs and the TransectMeasure text export (file ending _Dot Point Measurements.txt)

# Set directories----
rm(list=ls())

## STEP 1 - Set Project and Campaign -----

## Pilbara Marine Conservation Partnership ----
# Project<-"Pilbara Marine Conservation Partnership"

# Campaigns ----
# ID<-"2014-05_Exmouth.to.Dampier.shallow_stereoBRUVs" # needs to be re-analysed
# ID<-"2014-10_Exmouth.to.Dampier.deep_stereoBRUVs" # needs to be re-analysed
# ID<-"2014-10_Montebello.sanctuaries_stereoBRUVs"# BG 05/07/17
# ID<-"2014-10_Ningaloo.shallow.sanctuaries_stereoBRUVs"# needs to be re-analysed
# ID<-"2015-01_Montebello.transect_stereoBRUVs" # needs to be re-analysed
# ID<-"2015-04_Montebello.to.CapePreston.transect_stereoBRUVs" # Ellen analysing 03/07/17
# ID<-"2015-04_Dampier.Archipelago.shallow_stereoBRUVs" #Unsure if analysed - Labsheet is incomplete
# ID<-"2015-04_Exmouth.to.Barrow.shallow_stereoBRUVs" # not analysed
# ID<-"2015-08_Murions.transect.Sunday_stereoBRUVs" # BG 05/07/17
# ID<-"2015-08_Ningaloo.lagoon.sanctuaries_stereoBRUVs" # BG 05/07/17
# ID<-"2015-08_Ningaloo.deep.sanctuaries_stereoBRUVs" # needs to be re-analysed
# ID<-"2015-08_Ningaloo.shallow.sanctuaries_stereoBRUVs"  # needs to be re-analysed
# ID<-"2015-09_Bessieres.transect_stereoBRUVs" # not analysed
# ID<-"2015-09_Dampier.Archipelago_stereoBRUVs" #BG 05/07/17
# ID<-"2015-09_Dampier.transect_stereoBRUVs" # BG 05/07/17
# ID<-"2015-09_Exmouth.Gulf_stereoBRUVs" # BG 05/07/17
# ID<-"2015-09_Mackerel.Islands.shallow_stereoBRUVs" #  BG 05/07/17

## Barrow Island Gorgon ----
# Project<-"Barrow Island Gorgon"
# Campaigns ----
# ID <- "2008-10_Barrow.Island.Gorgon_stereoBRUVs" # not analysed
# ID <- "2009-10_Barrow.Island.Gorgon_stereoBRUVs" # not analysed
# ID <- "2010-10_Barrow.Island.Gorgon_stereoBRUVs" # not analysed

## Cape Howe Marine Park_Moore ----
#Project<-"Cape Howe Marine Park_Moore"

# Campaigns ----
#ID <- 2006-11_Cape.Howe.MNP_stereoBRUVs # do not have TMObs

## Dampier Archipelago Pluto ----
#Project<-"Dampier Archipelago Pluto"

# Campaigns ----
# ID <- 2008-08_Dampier.Pluto_stereoBRUVs # not analysed

## Department of Fisheries deepwater transects ----
#Project<-"Department of Fisheries deepwater transects"

# Campaigns ----
# ID <- "2010-03_Perth.Canyon.60_stereoBRUVs"
# ID <- "2010-03_Perth.Canyon.90_stereoBRUVs"
# ID <- "2010-03_Perth.Canyon.180_stereoBRUVs"
# ID <- "2010-11_Perth.Canyon.60_stereoBRUVs"
# ID <- "2010-11_Perth.Canyon.90_stereoBRUVs"


## Nagari Capes long-term monitoring ----
# Project <- "Nagari Capes long-term monitoring"

# Campaigns ----
# ID <- "2006-00_Capes.sanctuaries_stereoBRUVs"
# ID <- "2007-03_Capes.sanctuaries_stereoBRUVs"
# ID <- "2008-02_Capes.sanctuaries_stereoBRUVs"
# ID <- "2008-04_Capes.sanctuaries_stereoBRUVs"
# ID <- "2009-03_Capes.sanctuaries_stereoBRUVs"
# ID <- "2009-08_Capes.sanctuaries_stereoBRUVs"
# ID <- "2010-01_Capes.sanctuaries_stereoBRUVs"
# ID <- "2010-06_Capes.sanctuaries_stereoBRUVs"


## Ningaloo Marine Park WAMSI_Fitzpatrick ----
# Project <- "Ningaloo Marine Park WAMSI_Fitzpatrick"

# Campaigns ----
# ID <- "2006-07_Ningaloo.sanctuaries_stereoBRUVs"
# ID <- "2007-07_Ningaloo.sanctuaries_stereoBRUVs"


## Ningaloo Marine Park_DPaW ----
# Project <- "Ningaloo Marine Park_DPaW"

# Campaigns ----
# ID <- "2014-10_Ningaloo.shallow.sanctuaries_stereoBRUVs"
# ID <- "2015-08_Ningaloo.deep.sanctuaries_stereoBRUVs"
# ID <- "2015-08_Ningaloo.shallow.sanctuaries_stereoBRUVs"


## Rottnest Island long-term monitoring ----
# Project <- "Rottnest Island long-term monitoring"

# Campaigns ----
# ID <- "2008-04_Rottnest.MF_stereoBRUVs"
# ID <- "2013-06_Rottnest.MF_stereoBRUVs"


## Rottnest Island Marine Reserve long-term monitoring ----
# Project <- Rottnest Island Marine Reserve long-term monitoring

# Campaigns ----
# ID <- "2009-07_Rottnest.sanctuaries_stereoBRUVs"
# ID <- "2010-04_Rottnest.sanctuaries_stereoBRUVs"
# ID <- "2011-02_Rottnest.sanctuaries_stereoBRUVs"


## Securing Western Australias Marine Futures ----
# Project <- "Securing Western Australias Marine Futures"

# Campaigns ----
# ID <- "2007-03_Capes.MF_stereoBRUVs" # 04/07/17 BG
# ID <- "2007-05_Abrolhos.MF_stereoBRUVs" # 04/07/17 BG
# ID <- "2007-05_Jurien.Bay.MF_stereoBRUVs" # 04/07/17 BG
# ID <- "2007-09_Rottnest.MF_stereoBRUVs"
# ID <- "2007-11_Middle.Island.MF_stereoBRUVs" # 04/07/17 BG - One Sample not in metadata??
# ID <- "2007-11_Point.Ann.MF_stereoBRUVs" # Location of TMObs?
# ID <- "2007-11_Two.Peoples.MF_stereoBRUVs" # 04/07/17 BG
# ID <- "2008-02_Broke.Inlet.MF_stereoBRUVs" # Location of TMObs?

## Shark Bay_Clough ----
# Project <- "Shark Bay_Clough"

# Campaigns ----
# ID <- "2009-09_Shark.Bay_stereoBRUVs"


## West Australian Marine Science Institute Node 4.2 ----
# Project <- "West Australian Marine Science Institute Node 4.2"
# Campaigns ----
# ID <- "2008-04_Capes.Wrights.Bank_stereoBRUVs"
# ID <- "2008-10_Two.Rocks.WAMSI_stereoBRUVs"
# ID <- "2010-04_Rottnest.WAMSI_stereoBRUVs"
# ID <- "2010-04_TwoRocks.WAMSI_stereoBRUVs"
# ID <- "2010-05_Abrolhos.WAMSI_stereoBRUVs"
# ID <- "2010-05_Capes.WAMSI_stereoBRUVs"


## Wheatstone Project Offset DPaW ----
# Project <- "Wheatstone Project Offset DPaW"

# Campaigns ----
# ID <- "2016-01_Mackeral.Islands.Shallow_SPC"





## Houtman Abrolhos Reef Observation Areas long-term monitoring ----
# Project <- "Houtman Abrolhos Reef Observation Areas long-term monitoring"

# Campaigns ----
# ID <- "2004-11_Abrolhos.ROA_stereoBRUVs" # not analysed
# ID <- "2005-05_Abrolhos.ROA_stereoBRUVs" # not analysed
# ID <- "2006-06_Abrolhos.ROA_stereoBRUVs" # not analysed
# ID <- "2007-05_Abrolhos.ROA_stereoBRUVs" # 04/07/17 BG
# ID <- "2008-05_Abrolhos.ROA_stereoBRUVs"
# ID <- "2009-05_Abrolhos.ROA_stereoBRUVs" # A lot of issues with naming OpCodes - to ask Tim if better way to rename files
# ID <- "2010-05_Abrolhos.ROA_stereoBRUVs"


# STEP 2 - Set Custodian ----
custodian <- "Tim Langlois"
# custodian <- "Euan Harvey"
# custodian <- "Joachim Claudet"

# STEP 3 - Set Method ----
method <- "stereo-BRUVs"
# method <- "stereo-DOVs/UVC"

## STEP 4 - Set Directories ----
upload=paste("C:/Users/21301367/Google Drive/GlobalArchive_Uploads",custodian,Project,method,ID,sep="/") # Example Directory 
habitat.data=paste(upload,"TMObs",sep="/")

# STEP 5 - Load required libraries ----
detach("package:plyr", unload=TRUE)#will error - no worries
library(tidyr)
citation("tidyr")
library(dplyr)
citation("dplyr")
options(dplyr.width = Inf) #enables head() to display all coloums
library(ggplot2)
library(stringr)
library("readr") # allows you to save final data as text file


# STEP 6 - Load and format habitat annotation data from TransectMeasure----
setwd(habitat.data)
dir()

data<-paste(ID,"Dot Point Measurements.txt",sep="_")

hab<-read.delim(data,header=T,skip=4,stringsAsFactors=FALSE)%>%
  setNames(tolower(names(.)))%>%
  mutate(OpCode= str_replace_all(.$filename,c(".jpg" = "","_" = "", ".JPG" = "")))%>% 
  select(-c(filename,frame,time..mins.,date,location,site..,transect..,latitude,longitude,rugosity,depth,collector,fishing.status,spare,spare.1,code,x, x.1,radius..))

head(hab)

## PROJECT AND CAMPAIGN SPECIFIC FIXES -----
# Pilbara Marine Conservation Partnership ----
# 2015-08_Ningaloo.lagoon.sanctuaries_stereoBRUVs (Camera names on end of filename for pictures)----
# hab<-hab%>%
#  mutate(OpCode= str_replace_all(.$OpCode,c(".jpg" = "","_" = "", ".JPG" = "","L422"= "","L416"= "","L418"= "","L511"= "","L426"= "","R426"= "","L513"= "","L425"= "","R423"= "","R514"= "")))

# 2015-09_Mackerel.Islands.shallow_stereoBRUVs (Spelling mistake in relief classification) ----
# hab<-hab%>%
#  mutate(relief=ifelse(relief==".5. High strucutural complexity, large holes and caves. Vertical wall. ~90 substrate slope.",".5. High structural complexity, large holes and caves. Vertical wall. ~90 substrate slope.",relief)) # fixes error in spelling



# Securing Western Australian Marine Futures ----
# 2007-03_Capes.MF_stereoBRUVs (Mistakes in OpCode/filename)----
# hab<- hab%>%
#   mutate(OpCode= str_replace_all(.$OpCode,c("Alex Grochowski"="","Simon Grove"="","Di Watson"="","Kathy Zischka"="","Antony Payne"="","Ben Piek"="","Jordan Goetze"="","Cordelia Moore"="","Mike Byers"="","Maya Taing"="","Andrew Tennyson"="","C91"="","C71"="","C151"="","C131"="","C171"="","C51"="","C271"="","C291"="","C152"="","C153"="","C281"="","C241"="","C72"="")))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB18C111","MF-GB018",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB19","MF-GB019",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB36","MF-GB036",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB37C31","MF-GB037",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB44","MF-GB044",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB47C111","MF-GB047",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB57","MF-GB057",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB58","MF-GB058",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB61","MF-GB061",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB64","MF-GB064",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB74","MF-GB074",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB77","MF-GB077",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB80","MF-GB080",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB91","MF-GB091",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC11","MF-WC011",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC13C31","MF-WC013",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC14C31","MF-WC014",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC16C31","MF-WC016",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC17","MF-WC017",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC20","MF-WC020",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC21","MF-WC021",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC22","MF-WC022",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC25","MF-WC025",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC26","MF-WC026",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC27","MF-WC027",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC29","MF-WC029",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC30","MF-WC030",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC31","MF-WC031",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC33","MF-WC033",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC34C31","MF-WC034",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC36","MF-WC036",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC38C111","MF-WC038",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC39","MF-WC039",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC3","MF-WC003",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC40","MF-WC040",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC41","MF-WC041",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC43","MF-WC043",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC44","MF-WC044",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC46","MF-WC046",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC47","MF-WC047",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC49","MF-WC049",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC50","MF-WC050",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC52","MF-WC052",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC53","MF-WC053",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC55","MF-WC055",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC56","MF-WC056",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC58","MF-WC058",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC5","MF-WC005",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC61C31","MF-WC061",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC62","MF-WC062",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC63","MF-WC063",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC70","MF-WC070",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC73C31","MF-WC073",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC74","MF-WC074",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC75C31","MF-WC075",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC76","MF-WC076",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC77","MF-WC077",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC78","MF-WC078",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC79","MF-WC079",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC7","MF-WC007",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC80","MF-WC080",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC83","MF-WC083",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC84","MF-WC084",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC85C31","MF-WC085",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC86","MF-WC086",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC89","MF-WC089",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC8","MF-WC008",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC90","MF-WC090",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC94C31","MF-WC094",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC95","MF-WC095",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC97","MF-WC097",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC9","MF-WC009",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB145C31","MF-GB145",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-CNB1-4C31","MF-CNB1-4",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-CNB5-4C31","MF-CNB5-4",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB168C111","MF-GB168",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB192C31","MF-GB192",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-GB199C111","MF-GB199",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-INB1-5C31","MF-INB1-5",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-INB2-4C31","MF-INB2-4",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-INB4-3C31","MF-INB4-3",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-INB7-4C31","MF-INB7-4",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC101C31","MF-WC101",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC111C31","MF-WC111",OpCode))%>%
# mutate(OpCode=ifelse(OpCode=="MF-WC116C31","MF-WC116",OpCode))%>%
# filter(!OpCode%in%("MF-WC031"))%>%  
# mutate(morphology=NA)%>%
# mutate(type=NA)%>%
# select(-c(x.2, x.3))

# 2007-05_Abrolhos.MF_stereoBRUVs (Mistakes in OpCode/filename)----
# hab <- hab%>%
#   mutate(OpCode= str_replace_all(.$OpCode,c("Alex Grochowski"="","Simon Grove"="","Di Watson"="","Kathy Zischka"="","Antony Payne"="","Ben Piek"="","Jordan Goetze"="","Cordelia Moore"="","Mike Byers"="","Maya Taing"="","Andrew Tennyson"="","George Shed"="","Tim Wiegele"="","C91"="","C71"="","C151"="","C131"="","C171"="","C51"="","C271"="","C291"="","C152"="","C153"="","C281"="","C241"="","C72"="","C111"="","C112"="","C11"="","C31"="","C161"="","C81"="","C32"="")))

# 2007-05_Jurien.Bay.MF_stereoBRUVs (Mistakes in OpCode/filename)----
# hab <- hab%>%
#   mutate(OpCode= str_replace_all(.$OpCode,c("Alex Grochowski"="","Simon Grove"="","Di Watson"="","Kathy Zischka"="","Antony Payne"="","Ben Piek"="","Jordan Goetze"="","Cordelia Moore"="","Mike Byers"="","Maya Taing"="","Andrew Tennyson"="","George Shed"="","Tim Wiegele"="","Christy Kistner"="","C91"="","C71"="","C151"="","C131"="","C171"="","C51"="","C271"="","C291"="","C152"="","C153"="","C281"="","C241"="","C72"="","C111"="","C112"="","C11"="","C31"="","C161"="","C81"="","C32"="","C741"="","C173"="")))%>%
#   mutate(morphology=NA)%>%
#   mutate(type=NA)%>%
#   select(-c(x.2, x.3))

# 2007-11_Middle.Island.MF_stereoBRUVs (Mistakes in OpCode/filename)----
# hab <- hab%>%
#   mutate(OpCode= str_replace_all(.$OpCode,c("Alex Grochowski"="","Simon Grove"="","Di Watson"="","Kathy Zischka"="","Antony Payne"="","Ben Piek"="","Jordan Goetze"="","Cordelia Moore"="","Mike Byers"="","Maya Taing"="","Andrew Tennyson"="","George Shed"="","Tim Wiegele"="","Christy Kistner"="","Ben Ford"="","C91"="","C71"="","C151"="","C131"="","C171"="","C51"="","C271"="","C291"="","C152"="","C153"="","C281"="","C241"="","C72"="","C111"="","C112"="","C11"="","C31"="","C161"="","C81"="","C32"="","C741"="","C173"="","C191"="","C92"="","C132"="")))%>%
#   mutate(morphology=NA)%>%
#   mutate(type=NA)%>%
#   select(-c(x.2, x.3))


# 2007-11_Two.Peoples.MF_stereoBRUVs (Mistakes in OpCode/filename)----
# hab <- hab%>%
#   mutate(OpCode= str_replace_all(.$OpCode,c("Alex Grochowski"="","Simon Grove"="","Di Watson"="","Kathy Zischka"="","Antony Payne"="","Ben Piek"="","Jordan Goetze"="","Cordelia Moore"="","Mike Byers"="","Maya Taing"="","Andrew Tennyson"="","George Shed"="","Tim Wiegele"="","Christy Kistner"="","Ben Ford"="","Kurt Wiegele"="","C91"="","C71"="","C151"="","C131"="","C171"="","C51"="","C271"="","C291"="","C152"="","C153"="","C281"="","C241"="","C72"="","C111"="","C112"="","C11"="","C31"="","C161"="","C81"="","C32"="","C741"="","C173"="","C191"="","C92"="","C132"="","C172"="","C121"="")))%>%
#   mutate(morphology=NA)%>%
#   mutate(type=NA)%>%
#   select(-c(x.2, x.3))





# Houtman Abrolhos Reef Observation Areas long-term monitoring ----
# 2007-05_Abrolhos.ROA_stereoBRUVs (Mistakes in OpCode/filename)----
# hab <- hab%>%
#   mutate(OpCode= str_replace_all(.$OpCode,c("Di Watson"="","Jordan Goetze"="","C151"="","C31"="","C131"="","C71"="","C72"="","C32"="","C51"="","C151"="","C111"="","C112"="","C11"="","C171"="","C172"="","C132"="","C12"="")))
# 
# 




# Check format -----
head(hab)
unique(hab$OpCode)
sort(table(hab$OpCode),decreasing=TRUE) ### Test to see how many times an OpCode is used - each should be 20

# Check to see if matches metadata file ----
setwd(upload)
dir()
metadata<-read_tsv(paste(ID,'Metadata.txt',sep="_"))%>%
  rename(OpCode=Sample)

test<-anti_join(hab,metadata,by='OpCode')
test2<-anti_join(metadata,hab,by='OpCode')

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
  group_by(OpCode)%>%
  summarise_each(funs(sum))
head(fov.point.score,2)

unique(fov.point.score$OpCode)

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
  group_by(OpCode)%>%
  summarise_each(funs(sum))
head(relief.point.score,2)

# CREATE catami_broad------
broad.point.score<-hab%>%
  select(-c(fieldofview,morphology,type,relief))%>% 
  mutate(broad=ifelse(broad=="Octocoral/Black","Octocoral.Black",ifelse(broad=="Stony corals","Stony.corals",ifelse(broad=="Open Water","Open.Water",broad))))%>%#correct bad names
  mutate(broad=ifelse(broad=="1_Hard Corals","Hard Corals",broad))%>% # For old attribute file
  mutate(broad=ifelse(broad=="2_Macroalgae","Macroalgae",broad))%>%
  mutate(broad=ifelse(broad=="3_Consoldated Substrate","Consolidated",broad))%>% ## BG SPELLING FIX
  mutate(broad=ifelse(broad=="3_Consolidated Substrate","Consolidated",broad))%>%
  mutate(broad=ifelse(broad=="4_Unconsolidated Substrate","Unconsolidated",broad))%>%
  mutate(broad=ifelse(broad=="4_Unconsoldated Substrate","Unconsolidated",broad))%>%
  filter(!broad=="")%>%
  filter(!is.na(broad))%>%
  filter(!broad=="Unknown")%>%
  filter(!broad=="Open.Water")%>%
  mutate(broad=paste("Biota:",broad,sep = " "))%>%
  mutate(count=1)%>%
  group_by(OpCode)%>%
  spread(key=broad,value=count,fill=0)%>%
  select(-c(image.row,image.col))%>%
  group_by(OpCode)%>%
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
  group_by(OpCode)%>%
  spread(key=catami_broad_morphology_type,value=count,fill=0)%>%
  select(-c(image.row,image.col,broad,morphology,type))%>%
  group_by(OpCode)%>%
  summarise_each(funs(sum))
head(broad_morphology_type.point.score,2)


# Write final habitat data----
# join starting with relief - as this is most likely to have the most samples with habitat data
setwd(upload)
dir()

habitat.point.score<-relief.point.score%>%
  left_join(fov.point.score,by="OpCode")%>%
  #left_join(broad.point.score,by="OpCode")%>% #use this line if you broad.point.score
  left_join(broad_morphology_type.point.score,by="OpCode")%>% #use this line if you have morphology_type data (instead of above)
  rename(Sample=OpCode)%>%
  write_tsv(paste(ID,"Habitat.point.score.txt",sep="_"))

head(habitat.point.score,2)


##### PERCENT COVER & MEAN AND SD RELIEF #####
# fov.percent.cover<-fov.point.score%>%
#   mutate_each(funs(replace(.,is.na(.),0)))%>%
#   mutate(Total.Sum=rowSums(.[,2:(ncol(.))],na.rm = TRUE ))%>%
#   group_by(OpCode)%>%
#   mutate_each(funs(./Total.Sum), matches("fieldofview."))%>%
#   select(-Total.Sum)
# head(fov.percent.cover,2)

# relief.mean.and.sd<-hab%>%
#   filter(!broad%in%c("Unknown","Open Water"))%>%
#   filter(!relief%in%c("Unknown",""))%>%
#   select(-c(broad,fieldofview,image.row,image.col))%>% #morphology,type,
#   mutate(relief=ifelse(relief==".5. High strucutural complexity, large holes and caves. Vertical wall. ~90 substrate slope.",".5. High structural complexity, large holes and caves. Vertical wall. ~90 substrate slope.",relief))%>% # fixes error in spelling
#   mutate(relief.rank=substr(relief,2,2))%>%
#   select(-c(relief))%>%
#   mutate(relief.rank=as.numeric(relief.rank))%>%
#   group_by(OpCode)%>%
#   summarise(mean.relief= mean (relief.rank), sd.relief= sd (relief.rank))
# head(relief.mean.and.sd,2)
# unique(relief.mean.and.sd$broad)
# unique(relief.mean.and.sd$relief)

# broad.percent.cover<-broad.point.score%>%
#   mutate(Total.Sum=rowSums(.[,2:(ncol(.))],na.rm = TRUE ))%>%
#   group_by(OpCode)%>%
#   mutate_each(funs(./Total.Sum), matches("Biota:"))%>%
#   select(-Total.Sum)%>%
#   mutate(`Biota: Reef`=`Biota: Consolidated`+`Biota: Macroalgae`) #Add in a Reef classification  #+`Biota: Octocoral.Black` may need to remove Octocoral/Black 
# head(broad.percent.cover)

# broad_morphology_type.percent.cover<-broad_morphology_type.point.score%>%
#   mutate(Total.Sum=rowSums(.[,2:(ncol(.))],na.rm = TRUE ))%>%
#   group_by(OpCode)%>%
#   mutate_each(funs(./Total.Sum), matches("Biota:"))%>%
#   select(-Total.Sum)
# head(broad_morphology_type.percent.cover,2)

#setwd(upload)

# habitat.percent.cover.and.relief<-relief.mean.and.sd%>%
#   left_join(fov.percent.cover,by="OpCode")%>%
#   left_join(broad.percent.cover,by="OpCode")%>%
#   #left_join(broad_morphology_type.percent.cover,by="OpCode")%>% #use this line if you have morphology_type data
#   rename(Sample=OpCode)%>%
#   write_tsv(paste(ID,"Habitat.percent.cover.and.relief.txt",sep="_"))

# head(habitat.percent.cover.and.relief,2)