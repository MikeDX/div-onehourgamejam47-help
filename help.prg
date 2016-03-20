// ONE HOUR GAME JAM #47
// THEME: HELP

PROGRAM help;

GLOBAL

	score;
	
	STRUCT helpme[8]
		x=0;
		y=0;
		alive=0;
	END


LOCAL

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

	FOR(n=1;n<9;n++);

		get_point(0,3,n,&px,&py);

		helpme[n-1].x=px;
		helpme[n-1].y=py;
	END


	player();

	LOOP

		IF (rand(0,100)>90)

			n = rand(0,7);
	
			IF (helpme[n].alive==0)
				saveme(n);
			END
		END

		FRAME;
	END
END


PROCESS saveme(n);

BEGIN

	x=helpme[n].x;
	y=helpme[n].y;
	y-=15;
	graph=5;
	size=50;

	fire(x,y);

	helpme[n].alive=1;

	LOOP
		flags=1-flags;
		frame(2000);
	END

END


PROCESS fire(x,y);

BEGIN

	alive=1;
	graph=4;
	size=50;
	burn=10;
	n=0;

	REPEAT
		flags=1-flags;
		frame(200);
		n++;
	UNTIL(burn<1 || n>100);

	IF(n<100)
		score++;
		helpme[father.n].alive=0;
		signal(father,s_kill);
	ELSE
		father.graph=1;
	END
END




PROCESS player();

BEGIN

	graph=6;

	LOOP
		x=mouse.x;
		y=mouse.y;
		water(x,y);

		FRAME;
	END
END


PROCESS water(tx,ty);

PRIVATE 
	pid;

BEGIN

	graph =7;
	x=320;
	y=480;

	WHILE (fget_dist(x,y,tx,ty)>10)

		angle = fget_angle(x,y,tx,ty);
		advance(10);
		size=x/10;
		flags=1-flags;

		FRAME;
	END

	pid = collision(type fire);
	
	IF(pid)
		pid.burn--;
		pid.size-=2;
	END
END
