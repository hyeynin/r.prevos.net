#PRELIMINARIES
setwd("~/Documents/Genealogie/")
con <- file("HEUGEM.GED")
#con <- file("test.ged")
GedCom <- readLines(con)
close(con)
library(stringr)
GedCom <- str_trim(GedCom) #Strip whitespace from start and end of lines

#INDIVIDUALS
#Location Individuals
indi_lines <- grep("INDI", GedCom) #Lines where individual definitions start
population <- length(indi_lines)
print(paste(population, "individuals"))
markers <- unlist(str_locate_all(GedCom[indi_lines],"@"))
indi <- str_sub(GedCom[indi_lines],
                markers[seq(1,population*4,4)]+1,
                markers[seq(2,population*4,4)]-1)

#Define matrix
individuals <- matrix(nrow=population, ncol=6)
colnames(individuals) <- c("id", "house", "fullname", "gender", "basptism", "bap_place")
individuals <- as.data.frame(individuals)
individuals[,1] <- indi

#Extract data per individual
for (i in 1:population) {
  j <- 1
  while (str_sub(GedCom[indi_lines[i]+j],1,1)!="0") {
    line <- GedCom[indi_lines[i]+j]
    if (grepl("REFN", line)) {
      individuals[i,2] <- str_trim(str_sub(line,str_locate(line,"REFN")[2]+1))
    }
    if (grepl("NAME", line)) {
      individuals[i,3] <- str_trim(str_sub(line,str_locate(line,"NAME")[2]+1))
    }
    if (grepl("SEX", line)) {
      individuals[i,4] <- str_trim(str_sub(line,str_locate(line,"SEX")[2]+1))
    }
    if (grepl("CHR", GedCom[indi_lines[i]+j])) {
      k <- 1
      while (str_sub(GedCom[indi_lines[i]+j+k],1,1)!="1") {
        if (grepl("DATE",GedCom[indi_lines[i]+j+k])) {
          individuals[i,5] <- 
            str_trim(str_sub(GedCom[indi_lines[i]+j+k],str_locate(GedCom[indi_lines[i]+j+k],"DATE")[2]+1))
        }
        if (grepl("PLAC",GedCom[indi_lines[i]+j+k])) {
          individuals[i,6] <- 
            str_trim(str_sub(GedCom[indi_lines[i]+j+k],str_locate(GedCom[indi_lines[i]+j+k],"PLAC")[2]+1))
        }   
        k <- k+1
      }
    }
    j <- j+1
  }
}

#FAMILIES
#Location Individuals


#DISTINGUISH FAM FROM FAMC AND FRAMS???


fam_lines <- grep("FAM ", GedCom) #Lines where individual definitions start
relations <- length(fam_lines)
print(paste(relations, "relations"))
markers <- unlist(str_locate_all(GedCom[fam_lines],"@"))
fam <- str_sub(GedCom[fam_lines],
                markers[seq(1,relations*4,4)]+1,
                markers[seq(2,relations*4,4)]-1)
#Define matrix
families <- matrix(nrow=relations, ncol=3)
colnames(families) <- c("fam_id", "father", "mother")
families[,1] <- fam

#Extract data per individual
for (i in 1:relations) {
  j <- 1
  while (str_sub(GedCom[fam_lines[i]+j],1,1)!="0") {
    line <- GedCom[fam_lines[i]+j]
    print(line)
    if (grepl("HUSB", line)) {
      families[i,2] <- str_trim(str_sub(line,str_locate(line,"HUSB")[2]+1))
    }
    if (grepl("WIFE", line)) {
      families[i,3] <- str_trim(str_sub(line,str_locate(line,"WIFE")[2]+1))
    }
    j <- j+1
  }
}

addmargins(table(individuals$bap_place[individuals$house!="NA" & individuals$house!="H?"]))