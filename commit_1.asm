.data
    # Constante para imprimir menu
    menu_options: .asciiz "\n\nMENU:\n1 - Fahrenheit => Celsius \n2 - Fibonnacci \n3 - En?simo par \n4 - Sair\n"

    # Constante para solicitar a op??o desejada do menu
    input_option: .asciiz "\n Digite o n?mero da op??oo desejada: "

    # Constantes para as entradas de cada op??o
    input_fahrenheit: .asciiz "\nDigite a temperatura em Fahrenheit: "
    input_fibonnacci: .asciiz "\nDigite o valor do Fibonnacci: "
    input_enesimo:  .asciiz "\nDigite o valor do Enésimo par: "

    # Constantes para os resultados de cada op??o
    result_fahrenheit: .asciiz "\nA temperatura em C (celsius) é: "
    result_fibonnacci: .asciiz "\nO En?simo termo do Fibonnacci é: "
    result_enesimo:  .asciiz "\nO Enésimo par é: "

    # Constantes para auxiliar na fun?ao de convers?o de Fahrenheit para Celsius
    fahrenheit_sub_value: .float 32.0
    fahrenheit_mul_value: .float 5.0
    fahrenheit_div_value: .float 9.0

    # Constante para caso o usuário digite uma opcao inexistente do menu 
    invalid_option: .asciiz "A opcão desejada não existe, verifique o menu de opcoes e tente novamente!\n"

# Bloco do c?digo
.text

# Bloco de instru??es que exibe o menu com as opcoes do programa
menu:
    # Atribui para o registrador $a0 a constante  menu_options contendo a string do menu
    # $a0 = "\nMENU:\n1 - Fahrenheit => Celsius \n2 - Fibonnacci \n3 - En?simo par \n4 - Sair\n"
    la $a0, menu_options
    # Carrega para o registrador $v0 o n?mero 4 que corresponde a fun??o de print_string
    li $v0, 4
    # Executa a o print  do menu
    syscall

# Loop para ser sempre exibido o menu
loop:
    # Solicita a op??o do menu para o usu?rio
    la $a0, input_option
    li $v0, 4
    syscall

    # Ler o valor da op??o informada pelo o usu?rio
    li $v0, 5
    syscall
    # Transfere o valor do registrador $v0 para o $t0
    move $t0, $v0

    # Verifica o valor de $t0 (correspondente ao valor da op??o do usuario) chamando a fun??o correspondente
    # Por exemplo, o usuario digitou "1" vai entrar no bloco do codigo do Fahrenheit (option1).
    beq $t0, 1, option1
    beq $t0, 2, option2
    beq $t0, 3, option3
    beq $t0, 4, exit
    # Caso o usu?rio digite uma op??o inv?lida, ele chama o bloco "invalid" e imprime uma mensagem de alerta para o usu?rio.
    j invalid
    
option1:
    

option2:
    

option3:

exit:

invalid:
    