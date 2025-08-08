#!/bin/bash
echo "Validating Terraform..."
terraform validate
checkov -d .