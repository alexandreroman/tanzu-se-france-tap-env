# Copyright 2022 VMware. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

AZ_STORAGE_ACCOUNT := tap8213
AZ_RES_GROUP := tap-demo

all: init pave-infrastructure bootstrap-gitops

init:
	terraform init --backend-config=storage_account_name=${AZ_STORAGE_ACCOUNT} --backend-config=resource_group_name=${AZ_RES_GROUP}

pave-infrastructure:
	terraform apply -auto-approve -no-color -input=false
	kapp deploy --kubeconfig tap.kubeconfig -a tanzu-cluster-essentials-bootstrap -f tap-bootstrap.yaml -f .terraform/modules/tap_azure_single/vendor/tanzu-cluster-essentials-bootstrap --yes --diff-changes

bootstrap-gitops:
	kapp deploy --kubeconfig tap.kubeconfig -a tap-gitops -f tap.yaml -f .terraform/modules/tap_azure_single/gitops/bootstrap --yes --diff-changes
