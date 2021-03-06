{
MIT License
Copyright © 2018 Juan Peña
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
}

Program DecimalToBinary;

Uses sysutils, Math;

var
	operation, binary: integer;
	number: longint;
	str: string;
	
procedure SelectConvertionType;
begin
	WriteLn('Please, select a type of conversion: ');
	WriteLn('0 for Binary.');
	WriteLn('1 for Signed Binary. ');
	WriteLn('2 for One''s Complement.');
	WriteLn('3 for Two''s Complement.');
	WriteLn('4 for Excess 2^n-1.');
	readln(operation);

end;

procedure CheckType;
begin
	if(operation = 0) then
		writeln('Binary');
	
	if(operation = 1) then
		writeln('Signed Binary');
		
	if(operation = 2) then
		writeln('One''s Complement');
		
	if(operation = 3) then
		writeln('Two''s Complement');		
	
	if(operation = 4) then
		writeln('Excess 2^n-1');
		
	if(operation >= 5) or (operation < 0) then begin
		writeln('Invalid operation. Please, insert a valid operation.');
		writeln;
		SelectConvertionType;
        CheckType;
	end;
	writeln;
end;

{
procedure ResetVars; // for later usage
begin
	number:= 0;
	str:= '';
	binary:= 0;
end;
}

function Excess(number: integer): integer;
var
	MSB: integer; // Most Significant Bit
	
begin
	// ---
	MSB:= 0;
	while (number > 0) do begin
		number:= number div 2;
		MSB:= MSB + 1;
	end;
	Excess:= Round(power(2, (MSB)));

end;

procedure AskNumber;
begin
	writeln('Please, write a number and then press Enter.');
	writeln('');	
	write('Your number is: ');
end;

procedure ConvertToBinary;
begin

// ================================ [Binary] ================================

	if(operation = 0) then begin

		readln(number);
		
		if(number < 0) then begin
			writeln('You have inserted an invalid number. Please, input a number greater or equal to 0.');
			writeln();
			AskNumber;
			readln(number);
			
		end;

			
			while(number > 0) do begin
				binary := number mod 2;
				number := number div 2;
				str:= IntToStr(binary) + str;

			end;
			
			writeln('Which in binary equals to: ', str);

	end;
	
	
// ============================ [Signed Binary] ============================
	
	if(operation = 1) then begin

		readln(number);
		
		if(number < 0) then begin
			
			number:= abs(number);
			while(number > 0) do begin
				binary := number mod 2;
				number := number div 2;
				str:= IntToStr(binary) + str;
			end;
		str:= '1' + str;
		
		end
		
		else begin
		
			while(number > 0) do begin
				binary := number mod 2;
				number := number div 2;
				str:= IntToStr(binary) + str;

			end;
		
		str:= '0' + str;
		end;
		//
		writeln('Which in binary equals to: ', str);
	end;
	

	
// =========================== [One's complement] ===========================

	if(operation = 2) then begin
	
		readln(number);
		
		if(number < 0) then begin
			
			while(number < 0) do begin
				binary := number mod 2;
				number := number div 2;
				
				if(binary = 0)
				then binary:= 1
				else binary:= 0;
				
				str:= IntToStr(binary) + str;
			end;
		str:= '1' + str;
		
		end
		
		else begin
		
			while(number > 0) do begin
				binary := number mod 2;
				number := number div 2;
				str:= IntToStr(binary) + str;
			end;
		
		str:= '0' + str;
		end;
		
		writeln('Which in binary equals to: ', str);
	end;
	
// =========================== [Two's complement] ===========================

	if(operation = 3) then begin
	
		readln(number);
		
		if(number < 0) then begin
		
			number := number + 1;
			while(number < 0) do begin
				binary := number mod 2;
				number := number div 2;
				
				if(binary = 0)
				then binary:= 1
				else binary:= 0;
				
				str:= IntToStr(binary) + str;
			end;
		str:= '1' + str;
		
		end
		
		else begin
		
			while(number > 0) do begin
				binary := number mod 2;
				number := number div 2;
				str:= IntToStr(binary) + str;

			end;
		
		str:= '0' + str;
		end;
		//
		writeln('Which in binary equals to: ', str);
	end;
	
// ============================= [Excess 2⁽ⁿ⁻¹⁾] =============================	
	
	if(operation = 4) then begin
	
		readln(number);
		
		if(number < 0) then begin
			
			number:= abs(number);
			number:= number + Excess(number);
			
			while(number > 0) do begin
				binary := number mod 2;
				number := number div 2;
				str:= IntToStr(binary) + str;
			end;
		
		end
		
		else begin
		
			number:= number + Excess(number);
			while(number > 0) do begin
				binary := number mod 2;
				number := number div 2;
				str:= IntToStr(binary) + str;

			end;
		
		end;
		//
		writeln('Which in binary equals to: ', str);
	end;
end;

Begin

	SelectConvertionType;
	CheckType;
	AskNumber;
	ConvertToBinary;
	//ResetVars;
	
	readln(); // sin esta linea el programa de mierda se cierra y no vemos el result wey
	// without that line, the program exits and we don't see the result 'wey'
End.
