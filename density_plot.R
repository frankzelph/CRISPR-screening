## This code is from Eric Shifrut. ##
#### Fig 2A - density bars ####

library(ggplot2)

library(egg)

path.to.file = "myscreen.sgrna_summary.txt" # any mageck sgrna test output

sgrna.sum = read.delim(path.to.file,as.is = T)

 

LFC.range = c(-max(abs(sgrna.sum$LFC))*1.1,max(abs(sgrna.sum$LFC))*1.1)

d = density(subset(sgrna.sum,LFC > LFC.range[1] & LFC < LFC.range[2])$LFC,

            n = 256,from = LFC.range[1],to = LFC.range[2])

df.fill = data.frame(xbin = d$x, ydens = d$y)

 

select.genes = c("CBLB","CD5","UBASH3A","VAV1","CD3D","LCP2") # or whatever you wish

sgrna.sum$GeneOrder = factor(sgrna.sum$Gene,select.genes)

ggplot(subset(sgrna.sum,Gene %in% select.genes)) +

  geom_vline(data = df.fill,aes(xintercept=xbin,color = ydens),size = 1) +

  geom_vline(aes(xintercept=LFC),color='deeppink3') +

  #geom_bar(aes(x=LFC,fill=gene.grp),width = 0.02,position = 'identity') +

  scale_color_gradient(low = "Grey80", high = "Grey20",guide = F) +

  scale_x_continuous(limits = LFC.range) +

  facet_wrap(~GeneOrder,ncol = 1,strip.position = 'left') +

  theme_void() +

  theme(legend.position = "bottom",

        legend.direction = "vertical",

        strip.text.y = element_text(size = 8,angle=180,hjust=1),

        axis.text = element_blank())