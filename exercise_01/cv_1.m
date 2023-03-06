clear all;

mytime = datetime;
minutes = mytime.Hour * 60 + mytime.Minute + mytime.Second / 60;

binaryMinutes = float2bin(minutes, 20);

% Ve funkci float2bin neni osetreno, pokud parametr funkce dec_length bude roven
% nebo mensi nez nula

% Ve funkci float2bin neni osetreno, pokud parametr funkce number je zaporne cislo

% ohledne chyby pri prevodu, napadla me cast kodu, kde prevadim cisla za desetinnou
% carkou, protoze ta konverze trva tak dlouho, dokud je vypocitana desetinna cast
% nenulova nebo dojde k tomu, ze pocet cifer prekroci cislo ulozene v promenne 
% dec_length, takze pokud mam desetinnou cast kterou zapisu v realite hypoteticky
% pomoci 8 cifer a dec_length nastavim na 4, tak dostanu pouze priblizny vysledek.
% Dale je problem, pokud mam desetinnou cast hypoteticky 2/3, tedy nekonecny periodicky rozvoj, tedy
% i kdybych nastavil dec_length na hodne velke cislo, tak nenastane situace, ze
% desetinna cast bude nulova, protoze to je nekonecny periodicky rozvoj
