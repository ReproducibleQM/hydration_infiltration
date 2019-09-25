#This is our very first script file

#let's create some objects we can do operations on
a<-12
b<-13
c<-14

domath<-function(data1, data2, data3){
  result<-data1+data2/data3
  return(result)
}

domath(a,b,c)
domath(b,c,a)


condfunction<-function(data){
  if (data>13){
    message<-"It's warm enough"
  }else{
    message<-"It's too cold, get your sweater."
  }
  return(message)
}


vec<-c(a,b,c)
vec

for (i in 1:length(vec)){
  out<-condfunction(vec[i])
  print (vec[i])
  print(out)
}