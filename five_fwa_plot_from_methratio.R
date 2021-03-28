#!/usr/bin/env Rscript
args <- commandArgs(T)
###how to run
###rscript.r configure.txt outputdir
outdir=args[2]
print(args[1])
configure=read.delim(args[1],header=FALSE)
methratio.l=list()
plot.l=list()
for (i in 1:nrow(configure)){
    if ((configure[i,2] =="region0") || (configure[i,2]=="Region0")){
        methratio.l[[i]]=read.delim(as.character(configure[i,1]))
        methratio.l[[i]]=tryCatch(subset(methratio.l[[i]],methratio.l[[i]][,1]=="chr4" & methratio.l[[i]][,3]=="-" & methratio.l[[i]][,2] >= 13038059 & methratio.l[[i]][,2]<13038143 & methratio.l[[i]][,8] >= 20),error = function(c) "error")
        plot.l[[i]]=data.frame(pos=methratio.l[[i]][,2],type=methratio.l[[i]][,4],cov=methratio.l[[i]][,8],ratio=methratio.l[[i]][,7]/methratio.l[[i]][,8],region=rep(configure[i,2],nrow(methratio.l[[i]])),libname=rep(configure[i,3],nrow(methratio.l[[i]])))
    }
  if ((configure[i,2] =="region1") || (configure[i,2]=="Region1")){
  methratio.l[[i]]=read.delim(as.character(configure[i,1]))
  methratio.l[[i]]=tryCatch(subset(methratio.l[[i]],methratio.l[[i]][,1]=="chr4" & methratio.l[[i]][,3]=="-" & methratio.l[[i]][,2] >= 13038143 & methratio.l[[i]][,2]<=13038272 & methratio.l[[i]][,8] >= 20),error = function(c) "error")
  plot.l[[i]]=data.frame(pos=methratio.l[[i]][,2],type=methratio.l[[i]][,4],cov=methratio.l[[i]][,8],ratio=methratio.l[[i]][,7]/methratio.l[[i]][,8],region=rep(configure[i,2],nrow(methratio.l[[i]])),libname=rep(configure[i,3],nrow(methratio.l[[i]])))
  }
  if (configure[i,2] =="region2" || configure[i,2]=="Region2"){
    methratio.l[[i]]=read.delim(as.character(configure[i,1]))
    methratio.l[[i]]=tryCatch(subset(methratio.l[[i]],methratio.l[[i]][,1]=="chr4" & methratio.l[[i]][,3]=="-" & methratio.l[[i]][,2] >= 13038356 & methratio.l[[i]][,2]<=13038499 & methratio.l[[i]][,8] >= 20),error = function(c) "error")
    plot.l[[i]]=data.frame(pos=methratio.l[[i]][,2],type=methratio.l[[i]][,4],cov=methratio.l[[i]][,8],ratio=methratio.l[[i]][,7]/methratio.l[[i]][,8],region=rep(configure[i,2],nrow(methratio.l[[i]])),libname=rep(configure[i,3],nrow(methratio.l[[i]])))
    }
  if (configure[i,2] =="region3" || configure[i,2]=="Region3"){
    methratio.l[[i]]=read.delim(as.character(configure[i,1]))
    methratio.l[[i]]=tryCatch(subset(methratio.l[[i]],methratio.l[[i]][,1]=="chr4" & methratio.l[[i]][,3]=="-" & methratio.l[[i]][,2] >= 13038568 & methratio.l[[i]][,2]<=13038695 & methratio.l[[i]][,8] >= 20),error = function(c) "error")
    plot.l[[i]]=data.frame(pos=methratio.l[[i]][,2],type=methratio.l[[i]][,4],cov=methratio.l[[i]][,8],ratio=methratio.l[[i]][,7]/methratio.l[[i]][,8],region=rep(configure[i,2],nrow(methratio.l[[i]])),libname=rep(configure[i,3],nrow(methratio.l[[i]])))
    }
  if (configure[i,2] =="region4" || configure[i,2]=="Region4"){
    methratio.l[[i]]=read.delim(as.character(configure[i,1]))
    methratio.l[[i]]=tryCatch(subset(methratio.l[[i]],methratio.l[[i]][,1]=="chr4" & methratio.l[[i]][,3]=="+" & methratio.l[[i]][,2] >= 13034186 & methratio.l[[i]][,2]<=13034278 & methratio.l[[i]][,8] >= 20),error = function(c) "error")
    plot.l[[i]]=data.frame(pos=methratio.l[[i]][,2],type=methratio.l[[i]][,4],cov=methratio.l[[i]][,8],ratio=methratio.l[[i]][,7]/methratio.l[[i]][,8],region=rep(configure[i,2],nrow(methratio.l[[i]])),libname=rep(configure[i,3],nrow(methratio.l[[i]])))
    }
  if (configure[i,2] =="region5" || configure[i,2]=="Region5"){
    methratio.l[[i]]=read.delim(as.character(configure[i,1]))
    methratio.l[[i]]=tryCatch(subset(methratio.l[[i]],methratio.l[[i]][,1]=="chr4" & methratio.l[[i]][,3]=="+" & methratio.l[[i]][,2] >= 13044660 & methratio.l[[i]][,2]<=13044759 & methratio.l[[i]][,8] >= 20 ),error = function(c) "error")
    plot.l[[i]]=data.frame(pos=methratio.l[[i]][,2],type=methratio.l[[i]][,4],cov=methratio.l[[i]][,8],ratio=methratio.l[[i]][,7]/methratio.l[[i]][,8],region=rep(configure[i,2],nrow(methratio.l[[i]])),libname=rep(configure[i,3],nrow(methratio.l[[i]])))    
  }
}
plot=do.call(rbind,plot.l)
plot$type=factor(plot$type,levels=c("CG","CHG","CHH"))
plot_cov_ann=aggregate(plot$cov,list(plot$region,plot$libname),max)
plot_cov_ann=data.frame(region=plot_cov_ann[,1],libname=plot_cov_ann[,2],maxcov=plot_cov_ann[,3],
                        pos=aggregate(plot$pos,list(plot$region,plot$libname),mean)[,3],
                        cov=rep(aggregate(plot$cov,list(plot$libname),max)[,2],each=length(levels(plot$region))),
                        type=rep("CHH",nrow(plot_cov_ann)))
zf_sites=data.frame(xmin=c(13038252,13038297),xmax=c(13038269,13038314),
                    ymin=c(0,0),ymax=c(1,1),pos=c(13038252,13038252),ratio=c(1,1),type=c("CHH","CHH"),
                    region=c("region1","region1"))


pdf(paste0(outdir,"five_fwa.pdf"),width=10*length(levels(configure[,2])),height=nrow(configure)*0.8)
library(ggplot2)
pcov=ggplot(plot,aes(x=pos,y=cov,fill=type))
pcov=pcov+geom_bar(stat="identity")+
  facet_grid(libname~region,scales = "free")+theme_bw()+
  labs(title="FWA sites coverage",y="log10 Covered Cytosine Count")+
  theme(axis.title=element_text(size=15,face="bold"))+ 
  theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=20),panel.grid=element_blank())+
  theme(panel.grid.major = element_line(colour = "white"))+
  theme(panel.grid.minor = element_line(colour = "white"))+
  scale_fill_manual(values = c("#4592FD","#FCC83B","#69C68C"))
pcov+geom_text(data=plot_cov_ann,label=paste0("max_coverage=",plot_cov_ann$maxcov),colour="grey41",size=10)


pratio=ggplot(plot,aes(x=pos,y=ratio,fill=type))
pratio+geom_bar(stat="identity")+labs(title="FWA sites methylation ratio",y="Methylation ratio")+
  geom_rect(data=zf_sites,aes(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax),fill="coral2",alpha=0.2)+
  facet_grid(libname~region,scales = "free_x")+ylim(0,1)+theme_bw()+
  theme(axis.title=element_text(size=15,face="bold"))+ 
  theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=20),panel.grid=element_blank())+
  theme(panel.grid.major = element_line(colour = "white"))+
  theme(panel.grid.minor = element_line(colour = "white"))+
  scale_fill_manual(values = c("#4592FD","#FCC83B","#69C68C"))
dev.off()
