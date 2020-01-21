function patches=mygetpatches(Img,xid,yid,p_size,step)
% Created by Wen 01/2020
% wtang6@ncsu.edu

[ysize,xsize]=size(Img);

i=0;j=0;

x_size=xid+step*i+p_size;
y_size=yid+step*j+p_size;
patches=[];
while(y_size<=ysize)
    while(x_size<=xsize)
        tmp=Img(yid+step*j:yid+step*j+p_size-1,xid+step*i:xid+step*i+p_size-1);
        patches=[patches,tmp(:)];
        i=i+1;
        x_size=xid+step*i+p_size;
    end
    j=j+1;
    y_size=yid+step*j+p_size;
    i=0;
    x_size=xid+step*i+p_size;
end

end