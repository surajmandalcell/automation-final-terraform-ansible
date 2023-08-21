#!/bin/bash
cd ../ansible
echo "------------------------------------"
echo "Running ansible playbook"
echo "------------------------------------"


ansible-playbook  --verbose n01537188-playbook.yaml

echo "------------------------------------"
echo "Completed ansible playbook"
echo "------------------------------------"