PROGRAM bubble_sort;

CONST
  N = 100;

VAR
  list: array[1..N] of Integer;
  i, j, tmp: Integer;

PROCEDURE sort;
BEGIN
  j:=N;
  While j > 0 Do
  Begin
    For i:=1 To j Do
    Begin
      If list[i] > list[i+1] Then
      Begin
        tmp := list[i];
	list[i] := list[i+1];
	list[i+1] := tmp;
      End;
    End;
    j:=j-1;
  End;
END;

BEGIN
  writeln('Przed:');
  For i:=1 To N Do
  Begin
    list[i] := Random(n) + 1;
    write(list[i], ' ');
  End;
  writeln();
  
  sort;

  writeln('Po:');
  For i:=1 To N Do
  Begin
    write(list[i], ' ');
  End;
  writeln();
END.
