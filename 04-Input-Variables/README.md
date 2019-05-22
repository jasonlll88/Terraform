To have a real terraform configuration file that you can share and have version controlled it's necessary to parameterize some configurations


We are going to create another file _variables.tf_


## Ways to assign variables

1. Command-line
   
   `terraform apply -var 'name_of_instance=from-console'`
  
2. From a file
   
   terraform.tfvars 
   *.auto.tfvars
    These files matching automatically loads the variables, so only run

    `terraform apply`

3. From specific file
    For other name of file you can use the flag -var-file

   `terraform apply -var-file="terraform-specific-file.tfvars"`

4. From environment variables
    Terraform will read environment variables in the form of TF_VAR_name to find the value for a variable. 
    
    Only for string-type variables

    set an envar `export TF_VAR_name_of_instance=envar `

    then run `terraform apply`

    The variables defined in a file will overwrite the envars

5. UI input
    If there is missing some variables when you run `terraform apply`, it will ask you for the value of these variables.


You can define Strings, Lists and Maps