#! /bin/bash

### Remove blank lines, comments, and localhost entries
clean_host_entry(){
    sed '/^\s*$/d' | grep -v ^# | grep -v 127. | grep -v "::"
}

### Print unbound local-data records from a hostfile entry
print_unbound_record(){
  awk {'print "local-data:\""$2". IN A "$1"\""'}
}

### Remove empty local-data records
remove_empty_records(){
grep  -v 'local-data:". IN A '
}

### Do all the above
main(){
(clean_host_entry | print_unbound_record | remove_empty_records)<"$1"
}

# If no argument is supplied, read from /etc/hosts
[[ -z $1 ]] && main "/etc/hosts" || main "$1"

