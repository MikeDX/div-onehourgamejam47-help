// ONE HOUR GAME JAM #37

// THEME: HELP


PROGRAM help;

global

score;
struct helpme[8]
x=0;
y=0;
alive=0;
end


local

n;
px,py;
alive;
burn=0;

BEGIN
set_mode(640480);
load_fnt("help.fnt");
load_fpg("help.fpg");
write_int(1,0,0,0,&score);

put_screen(0,2);

graph=3;
x=320;
y=240;

//put_screen(0,3);

for(n=1;n<9;n++);

get_point(0,3,n,&px,&py);

helpme[n-1].x=px;
helpme[n-1].y=py;
//saveme(px,py);

end

player();



loop

if (rand(0,100)>90)

n = rand(0,7);
if (helpme[n].alive==0)
saveme(n);
end


end


frame;

end



END


process saveme(n);

begin
x=helpme[n].x;
y=helpme[n].y;
y-=15;
graph=5;
size=50;

fire(x,y);

helpme[n].alive=1;


loop
flags=1-flags;
frame(2000);

end

end


process fire(x,y);



begin
alive=1;
graph=4;
size=50;
burn=10;
n=0;

repeat
flags=1-flags;

frame(200);
n++;
until(burn<1 || n>100);
//collision(type water));

if(n<100)
score++;
helpme[father.n].alive=0;
signal(father,s_kill);
else
father.graph=1;
end

end




process player();


begin

graph=6;

loop

x=mouse.x;
y=mouse.y;

//if(mouse.left)

water(x,y);


//end
frame;

end

end


process water(tx,ty);

private pid;


//private fangle;
begin

graph =7;
x=320;
y=480;


while (fget_dist(x,y,tx,ty)>10)
//x!=tx && y!=ty)
angle = fget_angle(x,y,tx,ty);
advance(10);
size=x/10;
flags=1-flags;

frame;

end



pid = collision(type fire);
if(pid)
pid.burn--;
pid.size-=2;
end


end
