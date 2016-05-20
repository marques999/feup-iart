+==================================================================+
| 1.2 - CONTROLEX: Agente para Controlar a Temperatura de uma Sala |
+==================================================================+
Apresente um diagrama e o pseudo-código para um agente simples reflexo – CONTROLEX - para controlar a temperatura de uma sala.
Suponha que dispõe das perceções T1 e T2 correspondentes à temperatura da sala e à temperatura exterior e as acções AQ ligar o aquecedor,
NAQ – Desligar o aquecedor, AC – ligar o ar frio, NAC – Desligar o ar frio, AJ – abrir as janelas, NAJ – fechar as janelas.
Pretende-se que a temperatura da sala esteja entre os 22 e os 24 graus.
Sempre que seja possível usar as janelas para controlar a temperatura (não desperdiçando energia), tal deve ser efetuado.
Sempre que a temperatura esteja mais de 2 graus afastada da banda desejada (ou seja se a temperatura for inferior a 20 ou superior a 26 graus),
deve-se fechar as janelas e em vez disso, usar o aquecedor ou ar frio para repor a temperatura dentro da banda desejada. Use termos linguísticos para caracterizar a situação.

Como poderia construir um agente um pouco mais inteligente para este problema (que tipo de agente, perceções, estado do mundo, etc., usar)?

Percepções
-------------
	T1 : temperatura da sala
	T2 : temperatura exterior

Acções
-------------
	AQ   : ligar aquecedor
	NAQ  : não ligar aquecedor
	AC   : ligar ar frio
	NAC  : não ligar ar frio
	AJ   : abrir janelas
	NAJ  : não abrir janelas

      20          22  NORMAL  24          26
      ||          ||==========||          ||
--------------------------------------------------------
    |          |                    |              |
Muito Frio    Frio                Quente     Muito Quente


Muito Frio 	 : 	T1 < 20
				se "Muito Frio" então NAJ, AQ, NAC

	  Frio 	 : 	T1 € [20, 22[
	  			se "Frio" && T2 > 23 então AJ, NAQ, NAC senão NAJ, AQ, NAC

	Normal   :	T1 € [22, 24[
				se "Normal" então (null)

	Quente	 : 	T1 € [24, 26[
				se "Quente" && T2 < 23 então AJ, NAQ, NAC senão NAJ, NAQ, AC

Muito Quente :  T1 >= 26
				se "Muito Quente" então NAJ, NAQ, AC

+=================================================+
| 1.3 PISCINEX: Agente para Controlar uma Piscina | +=================================================+

Apresente um diagrama e o pseudo-código para um agente simples – PISCINEX -
para controlar o nível de água e a temperatura de uma piscina.
Suponha que dispõe das perceções TEMP correspondentes à temperatura da piscina
 e ALT correspondente à altura de água da piscina.
Pretende-se que a temperatura da piscina esteja entre os 25 e os 27 graus e que o nível de água esteja entre 1.3 e 1.5 metros.
É possível ligar simultaneamente uma das entradas e a saída da água mas não existe nenhuma garantia que o nível permaneça o mesmo.
Não se pode manter ligada a entrada de água quando o nível da água esteja superior a 1.55 metros.

Percepções:
	TEMP 	: temperatura da piscina
	ALT 	: nível da água

Acções:
	AS 		: abrir saída de água
	FS		: fechar saída da água
	AEQ 	: abrir entrada de água quente
	FEQ		: fechar entrada de água quente
	AEF		: abrir entrada de água fria
	FEF		: fechar entrada de água fria

[AS, FS]

[AEQ; FEQ]

[AEF, FEF]
	+-----------------------+
	|		|		|		|
	|	1	|	2	|	3	|
	|		|		|		|
1,5	+-------+-------+-------+
	|		|*******|		|
	|	4	|*******|	5	|
	|		|*******|		|
1,3	+-------+-------+-------+
	|		|		|		|
	|	6	|	7	|	8	|
	|		|		|		|
	+-----------------------+
		   25ºC    27ºC

Situação 1 	 : 	TEMP < 25 && ALT > 1.5
				se "Situação 1" então AS, AEQ, FEF

Situação 2 	 : 	TEMP € [25, 27] && ALT > 1.5
				se "Situação 2" então AS, FEQ, FEF

Situação 3 	 : 	TEMP > 27 && ALT > 1.5
				se "Situação 3" então AS, FEQ, AEF

Situação 4 	 : 	TEMP < 25 && ALT € [1.3, 1.5]
				se "Situação 4" então AS, AEQ, FEF

Situação 5 	 : 	TEMP > 27 && ALT € [1.3, 1.5]
				se "Situação 5" então AS, FEQ, AEF

Situação 6 	 : 	TEMP < 25 && ALT < 1.3
				se "Situação 6" então FS, AEQ, FEF

Situação 7 	 : 	TEMP € [25, 27] && ALT < 1.3
				se "Situação 7" então FS, AEQ, AEF

Situação 8 	 : 	TEMP > 27 && ALT < 1.3
				se "Situação 8" então FS, FEQ, AEF

Situação 0	 :	TEMP € [25, 27] && ALT € [1.3, 1.5]
				se "Situação 0" então (null)