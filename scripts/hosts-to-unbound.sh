#! /bin/bash

### Remove blank lines, comments, and localhost entries
clean_host_entry(){
    sed '/^\s*$/d' | grep -v ^# | grep -v 127. | grep -v "::"
}

### Print unbound local-data and local-data-ptr records from a hostfile entry
print_unbound_record(){
  awk {'print "local-data:\""$2". IN A "$1"\"\nlocal-data-ptr:\""$1" "$2"\""}'
}

### Remove empty local-data and local-data-ptr records
remove_empty_records(){
grep  -v 'local-data:". IN A ' | grep  -v 'local-data-ptr:" "'
}

### Do all the above
main(){
(clean_host_entry | print_unbound_record | remove_empty_records)<"$1"
}

# If no argument is supplied, read from /etc/hosts
[[ -z $1 ]] && main "/etc/hosts" || main "$1"

