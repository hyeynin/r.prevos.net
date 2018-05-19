
num <- vector()
den <- vector()
for (a in 11:99) {
    for (b in (a + 1):99) {
        trivial <- (a %% 10 == 0 | b && 10 == 0 | a %% 11 == 0 | b %% 11 == 0)
        if (!trivial) {
            i <- as.numeric(unlist(strsplit(as.character(a), "")))
            j <- as.numeric(unlist(strsplit(as.character(b), "")))
            digs <- c(i, j)
            dup <- digs[duplicated(digs)]
            digs <- digs[which(digs!=dup)]
            if (length(digs)==2 & a/b == digs[1]/digs[2]) {
                num <- c(num, a)
                den <- c(den, b)
                }
        }
    }
}


answer <- prod(den) / prod(num)
print(answer)
