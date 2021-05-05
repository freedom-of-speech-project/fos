## thanks @Kan Nishida for the Oauth explanation! https://blog.exploratory.io/extract-data-from-private-github-repository-with-rest-api-db804fa43d84

## LOAD IN DATA
# using .Reviron to store github token to access data from private repo (without storing auth details publicly)
# load httr package, get the github token stored locally in my .Renviron file, store the URL
library(httr) # https://cran.r-project.org/web/packages/httr/httr.pdf
Sys.getenv("GITHUB_PAT")
url <- "https://raw.githubusercontent.com/freedom-of-speech-project/fos-data/main/litetmdataset.csv?token=ALBDZW36M2ARO6OK52QS4JTAOMXNK"

# use httr function GET to pull and query and authenticate from github
req <- GET(url, 
           query = list(state = "all", per_page = 100, page = 1), 
           authenticate(Sys.getenv("GITHUB_PAT"), ""))

# use httr function content to separate content from HTTP request metadata
data <- content(req, type = "text/plain")

# explicitly name column names since the first column is an index, not included in fields
column.names <- c("number", "caseId","docketId","caseIssuesId","voteId","dateDecision","decisionType","usCite","term","naturalCourt","chief","docket","caseName","dateArgument","dateRearg","petitioner","petitionerState","respondent","respondentState","jurisdiction","adminAction","adminActionState","threeJudgeFdc","caseOrigin","caseOriginState","caseSource","caseSourceState","lcDisagreement","certReason","lcDisposition","lcDispositionDirection","declarationUncon","caseDisposition","caseDispositionUnusual","partyWinning","precedentAlteration","voteUnclear","issue","issueArea","decisionDirection","decisionDirectionDissent","authorityDecision1","authorityDecision2","lawType","lawSupp","lawMinor","majOpinWriter","majOpinAssigner","splitVote","majVotes","minVotes","landmark","cleansyl")

# read in table from comma-delimited HTTP content; quote="\"" is key to correctly parsing syllabus text data that contains many single and double quotation marks
data.df <- read.table(text = data, sep = ",", quote = "\"", fill = TRUE, encoding="UTF-8", col.names = column.names, header=TRUE)

## TEXT CLEANING
syllabus_texts <- data.df$cleansyl
#syllabus_texts <- strings.v
syllabus_texts <- gsub("'", "", syllabus_texts)  # remove apostrophes
syllabus_texts <- gsub("[[:punct:]]", " ", syllabus_texts)  # replace punctuation with space
syllabus_texts <- gsub("[[:cntrl:]]", " ", syllabus_texts)  # replace control characters with space
syllabus_texts <- gsub("^[[:space:]]+", "", syllabus_texts) # remove whitespace at beginning of syllabus_texts
syllabus_texts <- gsub("[[:space:]]+$", "", syllabus_texts) # remove whitespace at end of syllabus_texts
syllabus_texts <- gsub('[[:digit:]]+', '', syllabus_texts)  # remove number digits
syllabus_texts <- tolower(syllabus_texts)                   # force to lowercase
#syllabus_texts <- iconv(strings.v,to='UTF-8-MAC', sub='byte')  # make text formatting readable by Macs
head(syllabus_texts)

## TOPIC MODEL
syllabus.list <- strsplit(syllabus_texts, "[[:space:]]+") # recognize each word as a single token, and output all as a list

# compute the table of terms-- the number of times each word is used in the corpus
term.table <- table(unlist(syllabus.list))
term.table <- sort(term.table, decreasing = TRUE)
print(dim(term.table))
# remove terms that are stop words or occur fewer than 5 times (standard practice for topic modeling)
stopWordFile = "~/fos/data_and_processing/stopWordFile.txt"
fosStopWordFile = "~/fos/data_and_processing/fosStopWordFile.txt"
stop_words = scan(stopWordFile, what = "character", sep = "\n")
fos_stop_words = scan(fosStopWordFile, what = "character", sep = "\n")
del <- names(term.table) %in% stop_words | term.table < 5 # this number can also change
del <- names(term.table) %in% fos_stop_words | term.table < 5 # this number can also change
term.table <- term.table[!del]
term.table <- term.table[which(names(term.table) != "")]
vocab <- names(term.table)

# put the syllabus_texts into the format required by the lda topic modeling package:
get.terms <- function(x) {
  index <- match(x, vocab)
  index <- index[!is.na(index)]
  rbind(as.integer(index - 1), as.integer(rep(1, length(index))))
}
all.syllabus_texts <- lapply(syllabus.list, get.terms)

# define variables necessary for lda topic modeling
D <- length(all.syllabus_texts)
W <- length(vocab)
syl.length <- sapply(all.syllabus_texts, function(x) sum(x[2, ]))
N <- sum(syl.length)
term.frequency <- as.integer(term.table)

# MCMC and model tuning parameters:
K <- 25 # number of topics -- this one has the greatest effect on the results
G <- 5000 # number of iterations of sampling over the corpus
alpha <- 0.2 # scalar value of Dirichlet hyperparameter for topic proportions
eta <- 0.2 # scalar value of Dirichlet hyperparameter for topic multinomials

# Fit the model: (infer topics across corpus using the parameters above)
# documentation for lda package:   https://cran.r-project.org/web/packages/lda/lda.pdf
install.packages("lda")
library(lda)
set.seed(357) # random number generator, but allows results to be reproduced
# if correctly understood, randomly generated results, like the topics, can be replicated on a corpus
t1 <- Sys.time()
# run the topic model!
fit <- lda.collapsed.gibbs.sampler(documents = all.syllabus_texts, K = K, vocab = vocab,
                                   num.iterations = G, alpha = alpha,
                                   eta = eta, initial = NULL, burnin = 1,
                                   compute.log.likelihood = TRUE)
t2 <- Sys.time()
t2 - t1  # 20 topics took about 4 minutes on my laptop

# WRITE TO CSV
# make a "top.words" spreadsheet that contains the top 10 words in each of the 20 topics
top.words <- top.topic.words(fit$topics,10, by.score=TRUE)
write.csv(top.words, "tm-10-by-30-1a.csv", row.names=FALSE)
# determine propotional relationships between topics-- i.e. how important is each topic within a syllabus? or compared to the other topics?
topic.proportions <- t(fit$document_sums) / colSums(fit$document_sums)
# put column names on so that we know which topic is referred to
colnames(topic.proportions) <- apply(top.words, 2, paste, collapse=" ")

# RESHAPE for proportions
library(reshape2)
topic.proportions.df <- cbind(data.frame(topic.proportions),
                              syllabus=factor(1:length(all.syllabus_texts), labels = "syllabus"),
                              index=(strtoi(factor(1:length(all.syllabus_texts))))-1)
topic.proportions.melt.df <- melt(topic.proportions.df)

# show each syllabus's representation of topics
write.csv(topic.proportions.df, "tm-10-by-30-1a_TopicProportions.csv")

head(subset.data.df)
subset.data.df <- data.df[,c(1,13)]

# merge tm data with case data (74 columns x 522 rows, including topic proportions, metadata, and syllabus text)
merged.df <- merge(topic.proportions.df, subset.data.df, by.x = "index", by.y = "number")
write.csv(merged.df, "merged-tm-10-by-20-3.csv")

df2 = subset(merged.df, select = -c(cleansyl) )
head(df2)

write.csv(df2, "full-merged-tm-10-by-20-3.csv")


