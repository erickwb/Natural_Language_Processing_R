#name: Erick Correia Silva 
#lendo pagina da web e criando uma wordcloud
library(tm)
library(textreadr)
library(wordcloud)
library(RColorBrewer)

#criando corpus 
#fontes disponíveis
getSources()
#formatos
getReaders()
#criar corpus   PCorpus(): fisico, VCorpus: volátil em memória
#pegando dados da wikipedia
x = read_html("https://en.wikipedia.org/wiki/Artificial_intelligence" )
#geramos um corpus
corpus = VCorpus(VectorSource(x),readerControl = list(reader=readPlain,language = "eng"))

#Explorando o corpus
#resumo do corpus
inspect(corpus) 
#corpus de 1 a 100
inspect(corpus[1:100])  
#metadados do corpus 1
meta(corpus[[1]])  
#visualizar 1 corpus
inspect(corpus[[2]])  
#texto separado por linhas
as.character(corpus[[2]]) 
#só uma linha
as.character(corpus[[200]])[1]

#Tratamentos diversos
#tm_map para executar transformações
stopwords("portuguese")
#remove
corpus = tm_map(corpus, removeWords, stopwords("english"))
#excesso de espaços em branco
corpus = tm_map(corpus , stripWhitespace)
#pontuação
corpus  = tm_map(corpus , removePunctuation)
#numeros
corpus  = tm_map(corpus , removeNumbers)


#primeira Wordcloud
wordcloud(corpus,max.words=50,random.order=T,colors=rainbow(8),rot.per=0.5,use.r.layout=T)


#matriz de palavras frequentes
#TermDocumentMatrix  termos na linha
#DocumentTermMatrix  documentos na linha
freq = TermDocumentMatrix(corpus)
freq
#tranformao em matrix do R
matriz = as.matrix(freq)
#ordeno de acordo com frequencia
matriz = sort(rowSums(matriz),decreasing=TRUE)
#data frame
matriz = data.frame(word=names(matriz), freq=matriz)
head(matriz, n=100)
#encontra termos mais frequentes
findFreqTerms(freq,500,Inf)
#remove infrequentes
removeSparseTerms(freq, 0.4)

#segunda Wordcloud
wordcloud(matriz$word,matriz$freq,max.words=50,random.order=T,colors=rainbow(8),rot.per=0.5,use.r.layout=T)









