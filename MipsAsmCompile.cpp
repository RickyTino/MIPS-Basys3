#include<bits/stdc++.h>
#define RTYPE 0
#define ITYPE 1
#define JTYPE 2
#define JR    3
#define SHAMT 4
#define SHIFT 5
/*
对应OpCode
ADD   000000
SUB   000000
AND   000000
OR    000000
NOR   000000
XOR   000000
SLL   000000
SLLV  000000
SRA   000000
SRAV  000000
SRL   000000
SLT   000000
SLTU  000000

ADDI  001000
ANDI  001100
ORI   001101
XORI  001110
SLTI  001010
SLTIU 001011

J     000010
JAL   000011

BEQ   000100
BNE   000101

LB    100100
LW    100011
SB    101000
SW    101011

对应funct:
ADD   100000
SUB   100010
AND   100100
OR    100101
NOR   100111
XOR   100110
SLL   000000
SLLV  000100
SRA   000011
SRAV  000111
SRL   000010
SLT   101010
SLTU  101011
JR    001000
*/

using namespace std;

string bintohex(string res)
{
	string s;
	for(int i=0; i<32; i+=4){
		int hex = 0;
		for(int j=0; j<4; j++){
			hex*=2;
			hex += res[i+j] - '0';
		}
		switch(hex){
			case 0:  s.push_back('0'); break;
			case 1:  s.push_back('1'); break;
			case 2:  s.push_back('2'); break;
			case 3:  s.push_back('3'); break;
			case 4:  s.push_back('4'); break;
			case 5:  s.push_back('5'); break;
			case 6:  s.push_back('6'); break;
			case 7:  s.push_back('7'); break;
			case 8:  s.push_back('8'); break;
			case 9:  s.push_back('9'); break;
			case 10: s.push_back('A'); break;
			case 11: s.push_back('B'); break;
			case 12: s.push_back('C'); break;
			case 13: s.push_back('D'); break;
			case 14: s.push_back('E'); break;
			case 15: s.push_back('F'); break;
		}
	}
	return s;
}

string dectobin(string reg)
{
	int dec = 0;
	string res = "00000";
	for(int i = 0; i < reg.size(); i++){
		dec *= 10;
		dec += reg[i]-'0';
	}
	if(dec >= 32) return "11111";
	int i = 4;
	while(dec > 0){
		res[i] = (dec % 2) + '0';
		dec /= 2;
		i--;
	}
	return res;
}

string hextobin(string imme)
{
	string res = "";
	if(imme.size()>4) return "1111111111111111";
	for(int i=0; i<imme.size(); i++){
		switch(imme[i]){
			case '0': res+="0000"; break;
			case '1': res+="0001"; break;
			case '2': res+="0010"; break;
			case '3': res+="0011"; break;
			case '4': res+="0100"; break;
			case '5': res+="0101"; break;
			case '6': res+="0110"; break;
			case '7': res+="0111"; break;
			case '8': res+="1000"; break;
			case '9': res+="1001"; break;
			case 'A': res+="1010"; break;
			case 'B': res+="1011"; break;
			case 'C': res+="1100"; break;
			case 'D': res+="1101"; break;
			case 'E': res+="1110"; break;
			case 'F': res+="1111"; break;
		}
	}
	return res;
}
int typeofinst(string inst)
{
	if(inst == "ADD")   return 0;
	if(inst == "SUB")   return 0;
	if(inst == "AND")   return 0;
	if(inst == "OR")    return 0;
	if(inst == "NOR")   return 0;
	if(inst == "XOR")   return 0;
	if(inst == "SLL")   return 4;
	if(inst == "SLLV")  return 5;
	if(inst == "SRA")   return 4;
	if(inst == "SRAV")  return 5;
	if(inst == "SRL")   return 4;
	if(inst == "SLT")   return 0;
	if(inst == "SLTU")  return 0;
	if(inst == "ADDI")  return 1;
	if(inst == "ANDI")  return 1;
	if(inst == "ORI")   return 1;
	if(inst == "XORI")  return 1;
	if(inst == "SLTI")  return 1;
	if(inst == "SLTIU") return 1;
	if(inst == "J")     return 2;
	if(inst == "JAL")   return 2;
	if(inst == "JR")    return 3;
	if(inst == "BGT")   return 1;
	if(inst == "BLT")   return 1;
	if(inst == "BEQ")   return 1;
	if(inst == "BNE")   return 1;
	if(inst == "LB")    return 1;
	if(inst == "LW")    return 1;
	if(inst == "SB")    return 1;
	if(inst == "SW")    return 1;
}

string getopcode(string inst)
{
	if(inst == "ADD")    return "000000";
	if(inst == "SUB")    return "000000";
	if(inst == "AND")    return "000000";
	if(inst == "OR")     return "000000";
	if(inst == "NOR")    return "000000";
	if(inst == "XOR")    return "000000";
	if(inst == "SLL")    return "000000";
	if(inst == "SLLV")   return "000000";
	if(inst == "SRA")    return "000000";
	if(inst == "SRAV")   return "000000";
	if(inst == "SRL")    return "000000";
	if(inst == "SLT")    return "000000";
	if(inst == "SLTU")   return "000000";
	if(inst == "JR")     return "000000";
	if(inst == "ADDI")   return "001000";
	if(inst == "ANDI")   return "001100";
	if(inst == "ORI")    return "001101";
	if(inst == "XORI")   return "001110";
	if(inst == "SLTI")   return "001010";
	if(inst == "SLTIU")  return "001011";
	if(inst == "J")      return "000010";
	if(inst == "JAL")    return "000011";
	if(inst == "BGT")    return "000111";
	if(inst == "BLT")    return "000001";
	if(inst == "BEQ")    return "000100";
	if(inst == "BNE")    return "000101";
	if(inst == "LB")     return "100100";
	if(inst == "LW")     return "100011";
	if(inst == "SB")     return "101000";
	if(inst == "SW")     return "101011";
}

string getfunct(string inst)
{
	if(inst == "ADD")    return "100000";
	if(inst == "SUB")    return "100010";
	if(inst == "AND")    return "100100";
	if(inst == "OR")     return "100101";
	if(inst == "NOR")    return "100111";
	if(inst == "XOR")    return "100110";
	if(inst == "SLL")    return "000000";
	if(inst == "SLLV")   return "000100";
	if(inst == "SRA")    return "000011";
	if(inst == "SRAV")   return "000111";
	if(inst == "SRL")    return "000010";
	if(inst == "SLT")    return "101010";
	if(inst == "SLTU")   return "101011";
	if(inst == "JR")     return "001000";
}

int main()
{
	freopen("compileasm.txt", "r", stdin);
	freopen("Rom.dat", "w", stdout);
	string line, op, r1, r2, r3, imme, targ;
	string res;
	string opcode, funct;
	int instype;
	while(cin >> op){
		instype = 0;
		opcode = getopcode(op);
		instype = typeofinst(op);
		switch(instype){
			case RTYPE:
				cin >> r1 >> r2 >> r3;
				r1 = dectobin(r1);
				r2 = dectobin(r2);
				r3 = dectobin(r3);
				funct = getfunct(op);
				res = opcode + r2 + r3 + r1 + "00000" + funct;
				break;
			case ITYPE:
				cin >> r1 >> r2 >> imme;
				r1 = dectobin(r1);
				r2 = dectobin(r2);
				imme = hextobin(imme);
				if(op == "BGT" || op == "BLT") res = opcode + r1 + r2 + imme;
				else res = opcode + r2 + r1 + imme;
				break;
			case JTYPE:
				cin >> targ;
				targ = hextobin(targ);
				res = opcode + "0000000000" + targ;
				break;
			case JR:
				cin >> r1;
				r1 = dectobin(r1);
				funct = getfunct(op);
				res = opcode + r1 + "000000000000000" + funct;
				break;
			case SHAMT:
				cin >> r1 >> r2 >> r3;
				r1 = dectobin(r1);
				r2 = dectobin(r2);
				r3 = dectobin(r3);
				funct = getfunct(op);
				res = opcode + "00000" + r2 + r1 + r3 + funct;
				break;
			case SHIFT:
				cin >> r1 >> r2 >> r3;
				r1 = dectobin(r1);
				r2 = dectobin(r2);
				r3 = dectobin(r3);
				funct = getfunct(op);
				res = opcode + r3 + r2 + r1 + "00000" + funct;
		}
		cout << bintohex(res) << endl;
	}
	return 0;
}
