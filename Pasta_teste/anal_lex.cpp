#include <bits/stdc++.h>
using namespace std;

enum types {ID, NUM, END_OF_FILE, PLUS, MINUS, MUL, DIV, IF, ELSE};

using token = pair<int, variant<int, string>>;
vector<token> tokens;

map<variant<string, char>, types> symbols = {
    {'+', PLUS},
    {'-', MINUS},
    {'*', MUL},
    {'/', DIV},
    {"if", IF},
    {"else", ELSE} 
};

void le_num(int c){
    int num = c - '0';
    c = cin.get();
    while(isdigit(c)){
        num *= 10;
        num += c - '0';
        c = cin.get();
    }
    cin.unget();

    cout << "TOKEN NUM: " << num << '\n';
    tokens.push_back({NUM, num});
}

void le_id(char c){
    string id;
    id.push_back(c);
    c = cin.get();
    while(isalnum(c)){
        id.push_back( (char) c);
        c = cin.get();
    }
    cin.unget();

    if(symbols.find(id) != symbols.end()) cout << "PALAVRA ALOCADA: " << id << '\n';
    else{
        cout << "TOKEN ID: " << id << '\n';
        tokens.push_back({ID, id});
    }
}

void le_symb(int c){
    cout << "SYMB: " << (char) c << '\n';
}

void analisador(){
    int c;
    while((c = cin.get()) != '\n'){
        if(isspace(c)) continue;
        else if(symbols.find((char) c) != symbols.end()) le_symb(c);
        else if(isdigit(c)) le_num(c);
        else if(isalpha(c)) le_id((char) c);
        else {
            cerr << "caractere nao reconhecido\n";
            exit(-1);
        }
    }
}

int main(){

    analisador();

    cout << "TOKENS GUARDADOS:\n";
    for(auto e: tokens) cout << "TYPE: " << e.first << " VAL:" << (e.first == NUM ? to_string(get<int>(e.second)) : get<string>(e.second)) << '\n';

    return 0;
}