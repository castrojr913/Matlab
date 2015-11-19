%leer de archivo txt
function data=readFile(path)
cnt_total=0;
id=fopen(path);
while ~feof(id) 
    cnt_total=cnt_total+1;
    fgets(id);
end
fclose(id)
id=fopen(path);
data_=zeros(1,cnt_total);
cnt_total=0;
while ~feof(id) 
    cnt_total=cnt_total+1;
    data_(cnt_total)=double(sym(fgets(id)));
end
fclose(id)
data=data_;

