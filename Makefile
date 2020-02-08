network:
	cd 00-network/; \
	terraform apply -var-file=../vars/all.tfvars;

destroy_network:
	cd 00-network/; \
	terraform destroy -var-file=../vars/all.tfvars;

bastion:
	cd 01-bastion/; \
	terraform apply -var-file=../vars/all.tfvars;

destroy_bastion:
	cd 01-bastion/; \
	terraform destroy -var-file=../vars/all.tfvars;

dns:
	cd 04-dns/; \
	terraform apply -var-file=../vars/all.tfvars;

destroy_dns:
	cd 04-dns/; \
	terraform destroy -var-file=../vars/all.tfvars;

emr:
	cd 03-emr/; \
	terraform apply -var-file=../vars/all.tfvars;

destroy_emr:
	cd 03-emr/; \
	terraform destroy -var-file=../vars/all.tfvars;
