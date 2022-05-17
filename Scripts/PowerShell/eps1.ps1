#################################
# ESCRIPT PARA PING SWEEP       #
# DATA: 17/05/2022              #
# DEV.: JEAN FREDSON O. DANTAS  # 
# VER: 1.0                      #
#################################

param(
    [string]$p1,
    [string]$p2)
 
    if (!$p1) {
        echo " Easy Ping Sweep"
        echo " Exemplo de uso: .\eps.ps1 192.168.0"
        echo " --ApenasAtivos   -Mostra apenas os ativos"
    } else {
    ## echo ($p2)
        foreach ($ip in 1..254){ 
            $status = (Test-Connection -count 1 -comp "$p1.$ip" -Quiet) 
                if ($p2 -eq "--ApenasAtivos"){
                    if ($status -eq "True"){
                        echo ("$p1.$ip -> Ativo")
                    }
                } else {
                    echo ("$p1.$ip - > $status")
                }
                

        }
        
    }