%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

struct StudentDetail{
    name : felt,
    age : felt,
    gender : felt,
}

@storage_var
func admin_address() -> (address: felt){
}


@storage_var
func student_details(address: felt) -> (res: StudentDetail){
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr} (
    _address: felt
){
    admin_address.write(_address);
    return ();
}

@external
func store_details{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _name: felt, _age: felt, _gender: felt
){
    let (caller) = get_caller_address ();
    student_details.write(
        caller,
        StudentDetail (
            name = _name,
            age = _age,
            gender = _gender
        )
    );
    return ();
}

@view
func get_name{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _address: felt
) -> (name: felt){
    let (detail) = student_details.read(_address);
    let name = detail.name;
    return (name, );
}
