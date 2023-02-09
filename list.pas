uses CRT;

const MAX_LENGTH = 100;

type
  TNode = record
    Data: Integer;
    Next, Prev: ^TNode;
  end;
  TList = record
    Head, Tail: ^TNode;
    Length: Integer;
    Nodes: array[1..MAX_LENGTH] of TNode;
  end;

procedure InitializeList(var List: TList);
begin
  List.Head := nil;
  List.Tail := nil;
  List.Length := 0;
end;

procedure AddToBegin(var List: TList; Value: Integer);
var
  Node: ^TNode;
begin
  if List.Length = MAX_LENGTH then
  begin
    WriteLn('List is full');
    Exit;
  end;
  Inc(List.Length);
  Node := @List.Nodes[List.Length];
  Node^.Data := Value;
  Node^.Prev := nil;
  Node^.Next := List.Head;
  if List.Head <> nil then
    List.Head^.Prev := Node;
  List.Head := Node;
  if List.Tail = nil then
    List.Tail := Node;
end;

procedure AddToEnd(var List: TList; Value: Integer);
var
  Node: ^TNode;
begin
  if List.Length = MAX_LENGTH then
  begin
    WriteLn('List is full');
    Exit;
  end;
  Inc(List.Length);
  Node := @List.Nodes[List.Length];
  Node^.Data := Value;
  Node^.Next := nil;
  Node^.Prev := List.Tail;
  if List.Tail <> nil then
    List.Tail^.Next := Node;
  List.Tail := Node;
  if List.Head = nil then
    List.Head := Node;
end;

procedure AddAfter(var List: TList; Value: Integer; AfterValue: Integer);
var
  Node, Current: ^TNode;
begin
  if List.Length = MAX_LENGTH then
  begin
    WriteLn('List is full');
    Exit;
  end;
  Current := List.Head;
  while (Current <> nil) and (Current^.Data <> AfterValue) do
    Current := Current^.Next;
  if Current = nil then
  begin
    WriteLn('Element not found');
    Exit;
  end;
  Inc(List.Length);
  Node := @List.Nodes[List.Length];
  Node^.Data := Value;
  Node^.Next := Current^.Next;
  Node^.Prev := Current;
  if Current^.Next <> nil then
    Current^.Next^.Prev := Node;
  Current^.Next := Node;
  if Current = List.Tail then
    List.Tail := Node;
end;

procedure AddBefore(var List: TList; Value: Integer; BeforeValue: Integer);
  begin
  var Node, Current: ^TNode;
  if List.Length = MAX_LENGTH then
    begin
    WriteLn('List is full');
    Exit;
    end;
  Current := List.Head;
  while (Current <> nil) and (Current^.Data <> BeforeValue) do
  Current := Current^.Next;
  if Current = nil then
    begin
    WriteLn('Element not found');
    Exit;
    end;
  Inc(List.Length);
  Node := @List.Nodes[List.Length];
  Node^.Data := Value;
  Node^.Next := Current;
  Node^.Prev := Current^.Prev;
  if Current^.Prev <> nil then begin
  Current^.Prev^.Next := Node;
  Current^.Prev := Node;end;
  if Current = List.Head then
  List.Head := Node;
  end;

function Find(List: TList; Value: Integer): ^TNode;
  var
  Current: ^TNode;
  begin
  Current := List.Head;
  while (Current <> nil) and (Current^.Data <> Value) do
  Current := Current^.Next;
  Result := Current;
  end;

procedure DisplayNode(Node: ^TNode);
begin
  Writeln('Узел с элементом: ');
  WriteLn('Данные: ', Node^.Data);
  WriteLn('Указатель на предыдущий: ', Node^.Prev);
  WriteLn('Указатель на следующий: ', Node^.Next);
end;

procedure Delete(var List: TList; Value: Integer);
  var
  Node: ^TNode;
  begin
  Node := Find(List, Value);
  if Node = nil then
    begin
    WriteLn('Element not found');
    Exit;
    end;
  if Node^.Prev <> nil then
    Node^.Prev^.Next := Node^.Next;
  if Node^.Next <> nil then
    Node^.Next^.Prev := Node^.Prev;
  if Node = List.Head then
    List.Head := Node^.Next;
  if Node = List.Tail then begin
    List.Tail := Node^.Prev;
    Node^.Prev := nil;
    Node^.Next := nil;
    Dec(List.Length);end;
  end;

procedure DisplayList(List: TList);
var
  Current: ^TNode;
begin
  WriteLn('Элементы списка:');
  Current := List.Head;
  while Current <> nil do
  begin
    Write(Current^.Data, ' ');
    Current := Current^.Next;
  end;
  WriteLn;
end;

begin
  println('**********Двусвязный список**********');
  var L:TList;
  InitializeList(L);
  var r:integer;
  for var i:=1 to 5 do begin
    r:=random(-50,100);
    AddToBegin(L,r);
  end;
  DisplayList(L);
  var c:byte;
  repeat
  println('**********Работа со списком**********');
  println('1 - Добавить элемент в начало');
  println('2 - Добавить элемент в конец');
  println('3 - Вставить после элемента');
  println('4 - Вставить перед элементом');
  println('5 - Найти узел с элементом');
  println('6 - Удалить узел с элементом');
  println('0 - Выход');
  read(c);
  case c of 
    1:begin
      var el:integer;
      println('*************************************');
      el:=readinteger('Введите элемент: ');
      AddToBegin(L,el);
      DisplayList(L);
    end;
    2:begin
      var el:integer;
      println('*************************************');
      el:=readinteger('Введите элемент: ');
      AddToEnd(L,el);                              
      DisplayList(L);
    end;
    3:begin
      var el,aft:integer;
      println('*************************************');
      el:=readinteger('Введите элемент: ');
      aft:=readinteger('Введте элемент, после которого вставить: ');
      AddAfter(L,el,aft);
      DisplayList(L);
    end;
    4:begin
      var el,bef:integer;
      println('*************************************');
      el:=readinteger('Введите элемент: ');
      bef:=readinteger('Введте элемент, перед которым вставить: ');
      AddBefore(L,el,bef);
      DisplayList(L);
    end;
     5:begin
      var el,aft:integer;
      println('*************************************');
      el:=readinteger('Введите элемент: ');
      var X:^TNode;
      X:=Find(L,el);
      DisplayNode(X);
      end;
     6:begin
      var el,aft:integer;
      println('*************************************');
      el:=readinteger('Введите элемент: ');
      Delete(L,el);
      DisplayList(L);
      end;
  end;
  until c=0;
end.