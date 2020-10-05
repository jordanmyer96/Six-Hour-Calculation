library(dplyr)
library(lubridate)
library(haven)
library(openxlsx)
library(tidyverse)
library(stringr)

source("../Global_Functions.R")
cleaner()
source("../Global_Functions.R")

importVS <- read_sas("../../EDC/SV.sas7bdat")
importLB <- read_sas("../../EDC/LB_COLL.sas7bdat")
importIC <- read_sas("../../EDC/DS_IC.sas7bdat")

trimVisit <- importVS %>% 
  filter(Visit == "Day 0") %>% 
  mutate(Visit_Date = paste(SVDAT,SVTIM)) %>% 
  mutate(Visit_Date = ymd_hm(Visit_Date)) %>% 
  select(c(2,3,12)) %>% 
  set_names(c("Subject_Number","Site","Visit_Date"))

trimIC <- importIC %>% 
  mutate(IC_Date = paste(DSSTDAT,DSSTTIM)) %>% 
  mutate(IC_Date = ymd_hm(IC_Date)) %>% 
  select(c(2,3,14)) %>% 
  set_names(c("Subject_Number","Site","IC_Date"))

trimLB <- importLB %>% 
  filter(Visit == "Day 0") %>% 
  mutate(LB_Date = paste(LBDAT1,LBTIM1)) %>% 
  mutate(LB_Date = ymd_hm(LB_Date)) %>% 
  select(c(2,3,42)) %>% 
  set_names(c("Subject_Number","Site","Samp_Date"))

together <- left_join(trimVisit,left_join(trimIC,trimLB)) %>% 
  mutate(V0toSC = )
  
view(importLB%>% filter(!is.na(LBTIM2_NP_CODED)) %>% filter(LBTIM1!=LBTIM2_NP))

together$Visit_Time[1]- together$IC_Time[1]
as.Date(together$Visit_Time[1])
format(together$Visit_Time[1],"%H:%M")
lubridate::as_date(together$Visit_Time[1])
format(together$Visit_Date[1])
as_datetime(format(paste(together$Visit_Date[1],together$Visit_Time[1])))
(ymd_hm(paste(together$Visit_Date[1],together$Visit_Time[1]))-ymd_hm(paste(together$Visit_Date[2],together$Visit_Time[2]))
)+3
