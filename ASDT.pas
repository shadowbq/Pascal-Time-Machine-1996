{    ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
     º                                                                  º
     º            Name       : Scott MacGregor                          º
     º            Class      : Computer Science II - Honors, AP         º
     º            Period     : 2                                        º
     º            Assignment : PG 648 N 5                               º
     º            Date       : 10/30/96                                 º
     º                                                                  º
     º                       Program Summary                            º
     º                                                                  º
     º        This program creates an abstract data type. It can add,   º
     º    subtract, multiply, divide, two rational numbers. It can also º
     º    reduce a fraction to its lowest term.                         º
     º                                                                  º
     º                                                                  º
     º                                                                  º
     ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program ASDT;
  uses crt;

const                                   {variable dictionary}
  main=9;                                  {main textcolor}

Type
  num=record                               {record type}
        top:integer;                       {top of rational #}
        bot:integer;                       {bottom of rational #}
        n:integer;                         {whole numbers}
      end;

{----------------------------------------------------------------------}
procedure readin(var numw:num; a:integer); {reads in the number compared to}
                                           {the num passed into procedure}
  begin
    with numW do
      begin
        writeln('Enter in form of fraction(improper is ok).');
        write('Enter the numerator of the ',a,'# : ');
        readln(top);
        repeat
          write('Enter the dinominator of the ',a,'# : ');
          readln(bot);
          if bot=0
            then
              begin
                textcolor(4);
                writeln('The dinominator can''t be Zero');
                textcolor(main);
              end;{if..then}
        until bot <> 0;
        textcolor(main+2);
        writeln(a,'# is ',top,'/',bot);
        textcolor(main);
        n:=0;
      end;{with..do}
  end;{procedure}
{----------------------------------------------------------------------}
procedure getgcf(var num1,num2:num; var gcf:integer);{finds gcf}

  begin
    gcf:=num1.bot*num2.bot;
    writeln('The gcf of ',num1.top,'/',num1.bot,' and '
    ,num2.top,'/',num2.bot,' is ',gcf);
    num1.top:=num1.top*num2.bot;
    num2.top:=num2.top*num1.bot;
    num1.bot:=num1.bot*num2.bot;
    num2.bot:=num2.bot*num1.bot;
  end;

{----------------------------------------------------------------------}

{**********************************************************************}
procedure reduce(var wnum:num); {This procedure gets rid of zeros,}
                                {gets rid of improper fractions,  }
  var                           {and reduces the proper fraction. }
    i:integer;
    zero:boolean;

  begin
    with wnum do
      begin
        zero:=false;

        {gets rid of zeros}
        if top = 0
          then
            begin
              bot:=0;
              top:=0;
              zero:=true;
            end;

        {gets rid of improper fractions}
        if not zero
          then
            begin
              n:=top div bot;
              top:=top - bot*n;
            end;

        {reduces the proper fraction}
        if not zero
          then
            for i:=bot downto 1 do
              if (top mod i = 0) and (bot mod i = 0)
                then
                  begin
                    top:=top div i;
                    bot:=bot div i;
                  end;

        textcolor(main+1);

        if n<> 0
          then
            if top <> 0
              then
                writeln('The answer is ',n,' ',top,'/',bot)
              else
                writeln('The answer is ',n)
          else
            if top <> 0
              then
                writeln('The answer is ',top,'/',bot)
              else
                writeln('The answer is 0');

        textcolor(main);
      end;
    readln;
    clrscr;
  end;{reduce}

{**********************************************************************}
procedure addorsub(num1,num2:num; a,b:integer); {adds,subtracts 1 from 2}
  var                                           {or sub 2 from 1}
    ans:num;                                    {number to pass to reduce}
    gcf:integer;                                {gcf}

  begin
    getgcf(num1,num2,gcf);
    if a=1
      then
        begin
          writeln('This adds the two numbers');
          ans.top:=num1.top+num2.top;
          ans.bot:=gcf;
        end
      else
        if b=1
          then
            begin
              writeln('This subtracts #1 from #2');
              ans.top:=num1.top - num2.top;
              ans.bot:=gcf;
            end
          else
            begin
              writeln('This subtracts #2 from #1');
              ans.top:=num2.top - num1.top;
              ans.bot:=gcf;
            end;

    reduce(ans);
    readln;
  end;{addorsub}


{**********************************************************************}

procedure multiordiv(num1,num2:num;a,b:integer);{multiply or divide 2 from 1}
  var                                           {divide 1 from 2}
    ans:num;

  begin
    if a = 1
      then
        begin
          writeln('This multiplies #1 and #2');
          ans.top:=num2.top * num1.top;
          ans.bot:=num2.bot * num1.bot;
        end
      else
        if b=1
          then
            begin
              writeln('This divides #1 from #2');
              ans.top:=num1.top * num2.bot;
              ans.bot:=num1.bot * num2.top;
            end
          else
            begin
              writeln('This divides #2 from #1');
              ans.top:=num2.top * num1.bot;
              ans.bot:=num2.bot * num1.top;
            end;
    reduce(ans);
    readln;
  end;{multi}


{**********************************************************************}
{######################################################################}
procedure mainrun;     {How many to read in and the menus case}
  Var
    num1:num;                      {the first number}
    num2:num;                      {the secound number}
    choice,ch2:integer;            {the choice identifiers}

  begin
   repeat
    repeat
      writeln;
      writeln(' ':30,'- M E N U -');
      writeln;
      writeln(' ':8,'1:Reduce Fraction             2:Add two rational #''s');
      writeln(' ':8,'3:Subtract two ration #''s     4:Divide two rational #''s');
      writeln(' ':8,'5:Multiply two rational #''s   6:Quit');
      writeln;
      write('What to do? : ');
      readln(choice);
    until (choice>0) and (choice<7);
    {how many to read in}
    if choice <> 6
      then
        readin(num1,1);
    if (choice <> 1) and (choice <> 6)
      then
         readin(num2,2);
    {the menus case}
    writeln;
    case choice of
      1:reduce(num1);
      2:addorsub(num1,num2,1,0);
      3:begin
          repeat
            writeln('1: #1 - #2');
            writeln('2: #2 - #1');
            write('[1,2]: ');
            readln(ch2);
          until (ch2=1) or (ch2=2);
          case ch2 of
            1:addorsub(num1,num2,2,1);
            2:addorsub(num1,num2,2,2);
          end;
        end;
      4:begin
          repeat
            writeln('1: #1 / #2');
            writeln('2: #2 / #1');
            write('[1,2]: ');
            readln(ch2);
          until (ch2=1) or (ch2=2);
          case ch2 of
            1:multiordiv(num1,num2,2,1);
            2:multiordiv(num1,num2,2,2);
          end;
        end;
      5:multiordiv(num1,num2,1,0);
    end{case..of};
   until choice = 6;
  end;{procedure}


{######################################################################}

BEGIN{driver}

  clrscr;
  textcolor(main+1);
  writeln('This is my Abstract Data Type Project':56);
  textcolor(main);
  mainrun;
  textcolor(main+1);
  writeln('By: Scott Macgregor 10/30':1110);
  textcolor(7);
  readln;

END.{fine!}
