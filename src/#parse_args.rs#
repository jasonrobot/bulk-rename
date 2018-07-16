use std::fmt;

#[derive(Debug)]
enum RenamerName {
    INSERT,
    REMOVE,
}

impl fmt::Display for RenamerName {
    fn fmt(&self , f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:?}", self)
    }
}

const RENAMER_NAMES : Vec<&str> = vec![
    "insert",
    "remove",
];

fn get_renamer() ->  RenamerName {
    
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_get_renamer() {
        let argv = vec!["foo", "bar", "baz", "insert", "qwe", "asd", "zxc"];
        let result = get_renamer();
    }
}
