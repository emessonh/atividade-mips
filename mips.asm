.data
    # Constante para imprimir menu
    menu_options: .asciiz "\n\nMENU:\n1 - Fahrenheit => Celsius \n2 - Fibonnacci \n3 - Enesimo par \n4 - Sair\n"

    # Constante para solicitar a opcao desejada do menu
    input_option: .asciiz "\n Digite o n?mero da opcaoo desejada: "

    # Constantes para as entradas de cada opcao
    input_fahrenheit: .asciiz "\nDigite a temperatura em Fahrenheit: "
    input_fibonnacci: .asciiz "\nDigite o valor do Fibonnacci: "
    input_enesimo:  .asciiz "\nDigite o valor do Enésimo par: "

    # Constantes para os resultados de cada opcao
    result_fahrenheit: .asciiz "\nA temperatura em C (celsius) é: "
    result_fibonnacci: .asciiz "\nO En?simo termo do Fibonnacci é: "
    result_enesimo:  .asciiz "\nO Enésimo par é: "

    # Constantes para auxiliar na fun?ao de conversao de Fahrenheit para Celsius
    fahrenheit_sub_value: .float 32.0
    fahrenheit_mul_value: .float 5.0
    fahrenheit_div_value: .float 9.0

    # Constante para caso o usuário digite uma opcao inexistente do menu 
    invalid_option: .asciiz "A opcão desejada não existe, verifique o menu de opcoes e tente novamente!\n"

# Bloco do codigo
.text

# Bloco de instrucoes que exibe o menu com as opcoes do programa
menu:
    # Atribui para o registrador $a0 a constante  menu_options contendo a string do menu
    # $a0 = "\nMENU:\n1 - Fahrenheit => Celsius \n2 - Fibonnacci \n3 - Enesimo par \n4 - Sair\n"
    la $a0, menu_options
    # Carrega para o registrador $v0 o numero 4 que corresponde a funcao de print_string
    li $v0, 4
    # Executa a o print  do menu
    syscall

# Loop para ser sempre exibido o menu
loop:
    # Solicita a opcao do menu para o usuario
    la $a0, input_option
    li $v0, 4
    syscall

    # Ler o valor da opcao informada pelo o usuario
    li $v0, 5
    syscall
    # Transfere o valor do registrador $v0 para o $t0
    move $t0, $v0

    # Verifica o valor de $t0 (correspondente ao valor da opcao do usuario) chamando a funcao correspondente
    # Por exemplo, o usuario digitou "1" vai entrar no bloco do codigo do Fahrenheit (option1).
    beq $t0, 1, option1
    beq $t0, 2, option2
    beq $t0, 3, option3
    beq $t0, 4, exit
    # Caso o usuario digite uma opcao invalida, ele chama o bloco "invalid" e imprime uma mensagem de alerta para o usuario.
    j invalid
    
option1:
    # Atribui para o registrador $a0 a constante input_fahrenheit contendo a string: "Digite a temperatura em Fahrenheit:"
    la $a0, input_fahrenheit
    # Imprime a contante input_fahrenheit na tela com sua respectiva mensagem
    li $v0, 4
    syscall

    # Recebe do usuario o valor em float
    li $v0, 6
    syscall
    # Move o valor digitado armazenado em $f0 para $f1
    mov.s $f1, $f0
    
    # Carrega o valor ponto flutuante armazenado na memoria da constante fahrenheit_sub_value para $f2
    # $f2 = 32.0 (valor de fahrenheit_sub_value) 
    lwc1 $f2, fahrenheit_sub_value

    # Bloco para conversao de Fahrenheit para Celcius
    # C = (F-32).5/9
    # 1? Calcula F-32
    # 2? Calcula o resultado do passo 1? (F-32) * 5
    # 3? Calcula o resultado do passo 2? (F-32) * 5 dividido por 9

    sub.s $f1, $f1, $f2  #  1? Passo
    # Carrega o valor ponto flutuante armazenado na memoria da constante fahrenheit_mul_value para $f2
    # $f2 = 5.0 (valor de fahrenheit_sub_value) 
    lwc1 $f2, fahrenheit_mul_value

    mul.s $f1, $f1, $f2 # 2? Passo
    # Carrega o valor ponto flutuante armazenado na memoria da constante fahrenheit_div_value para $f2
    # $f2 = 9.0 (valor de fahrenheit_sub_value)
    lwc1 $f2, fahrenheit_div_value
    div.s $f1, $f1, $f2 # 3? Passo

    # Exibir a tempeperatura em Celsius

    # Atribiui para $a0 a string que esta na constante result_fahrenheit
    la $a0, result_fahrenheit
    # Imprime na tela a mensagem "A temperatura em C (celsius) ?: "
    li $v0, 4
    syscall

    # Atribui o valor de $f1 para $f12, ou seja $f12 = $f1
    mov.s $f12, $f1  
    # Chama a funcao para imprimir o valor float que esta no registrador $f1
    li $v0, 2
    syscall

    j menu

option2:
    # Atribui para $a0 o valor da contante input_fibonnacci
    la $a0, input_fibonnacci
    # Atribui o valor da fun??o que ira imprimir uma string
    li $v0, 4
    # Imprime a mensagem em tela da contante input_fibonnacci
    syscall
    
    # Atribui para $v0 o valor 5 que corresponde a fun??o de ler um inteiro
    li $v0, 5
    # Ler o valor de um inteiro
    syscall
    move $t0, $v0  # Armazenar o valor digitado pelo usu?rio em $t0
    
    # Verificar se o valor digitado ? 0, se caso for, chama o bloco display_fibonacci
    blez $t0, display_fibonacci
    
    # Atribui $t1 = 0
    li $t1, 0
    
    # Atribui $t2 = 1
    li $t2, 1
    
    # Loop para calcular os termos de Fibonacci
    li $t3, 2   # Iniciar o contador em 2
    loop_fibonacci:
        add $t4, $t1, $t2   # F = F(n-1) + F(n-2)
        move $t1, $t2       # F(n-1) = F(n-2)
        move $t2, $t4       # F(n-2) = F
        
        addi $t3, $t3, 1    # Incrementar o contador
        
        # Verificar se alcan?ou o en?simo termo desejado
        beq $t3, $t0, display_fibonacci
        blt $t3, $t0, loop_fibonacci

    display_fibonacci:
    # Atribui o valor de $a0 a constante de result_fibonnacci
    la $a0, result_fibonnacci
    # Atribui o valor de $v0 = 4, correspondendo ao "print_string"
    li $v0, 4
    # Exibir o en?simo termo da sequ?ncia de Fibonacci
    syscall
    
    move $a0, $t2   # Colocar o resultado em $a0 para exibi??o
    # $vo = 1, que corresponde ao "print_int"
    li $v0, 1
    # Chama a fun??o de printar o valor inteiro 
    syscall

    # Chama o menu inicial
    j menu


option3:
    #  Atribui $a0 = o valor da constante input_enesimo
    la $a0, input_enesimo
    # Atribui $v0 = 4, que corresponde ao "print_string"
    li $v0, 4
    # Chama a funcão e exibe em tela o string que esta no input_fibonnacci
    syscall
    
    # $v0 = 5 => ler o valor de um inteiro (read_int)
    li $v0, 5
    # Aguarda o usuairo digitar um valor inteiro
    syscall
    move $t0, $v0  # Armazenar o valor digitadod em $t0

    # $t0 = $t0 x 2
    mul $t0, $t0 , 2

    # $a0 = result_enesimo
    la $a0, result_enesimo
    # Atribui o valor 4 a $v0 que  corresponde ao print_string
    li $v0, 4
    # Imprime em tela o valor que esta armazenado na constante result_enesimo
    syscall
    
    move $a0, $t0 # Colocar o resultado em $a0 para exibilo
    # imprime inteiro
    li $v0, 1
    # imprime numero inteiro que esta salvo no $v0
    syscall
    
    # chama menu
    j menu
exit:
    # Terminar o programa
    li $v0, 10
    syscall

invalid:
    # Mensagem para escolha da opcao invalida
    la $a0, invalid_option
    li $v0, 4
    syscall
    j menu
