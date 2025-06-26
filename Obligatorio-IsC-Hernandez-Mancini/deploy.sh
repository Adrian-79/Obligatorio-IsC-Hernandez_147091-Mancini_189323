###############################################
#deploy.sh
###############################################

#!/bin/bash

set -e

INFRA_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$INFRA_DIR/logs"
mkdir -p "$LOG_DIR"

echo "=========================================="
echo " Script de Despliegue AWS (Terraform)"
echo "=========================================="
echo ""

PS3="Selecciona una opción: "

options=(
  "1. Inicializar Terraform"
  "2. Verificar Plan de Infraestructura"
  "3. Aplicar Infraestructura"
  "4. Mostrar DNS del Load Balancer"
  "5. Destruir Infraestructura"
  "6. Salir"
)

select opt in "${options[@]}"
do
  case $REPLY in

    1)
      echo "Inicializando Terraform..."
      cd "$INFRA_DIR"
      terraform init | tee "$LOG_DIR/init.log"
      echo "Inicialización completada."
      ;;

    2)
      echo "Mostrando plan de infraestructura..."
      cd "$INFRA_DIR"
      terraform plan | tee "$LOG_DIR/plan.log"
      ;;

    3)
      echo "Aplicando infraestructura (esto puede tardar)..."
      cd "$INFRA_DIR"
      terraform apply -auto-approve | tee "$LOG_DIR/apply.log"
      echo "Infraestructura desplegada correctamente."
      ;;

    4)
      echo "Obteniendo DNS público del Load Balancer..."
      cd "$INFRA_DIR"
      terraform output load_balancer_dns
      ;;

    5)
      echo "Destruyendo toda la infraestructura..."
      cd "$INFRA_DIR"
      terraform destroy -auto-approve | tee "$LOG_DIR/destroy.log"
      echo "Infraestructura eliminada."
      ;;

    6)
      echo "Saliendo del script. ¡Hasta luego!"
      break
      ;;

    *)
      echo "Opción inválida. Elegí un número entre 1 y ${#options[@]}"
      ;;
  esac
done


###################################################################
#NOTA: Cómo usarlo
#Desde la carpeta infra/, ejecutá:

#chmod +x deploy.sh
#./deploy.sh

#Detalles
#Guardar los logs en infra/logs/ para revisión posterior.
#Manejo de errores (set -e) para que cualquier fallo se detenga el script.
#No requiere ingresar yes manualmente (uso de -auto-approve).
#NOTA: debe usarse desde un entorno bash (Git Bash o WSL en Windows)
######################################################################


