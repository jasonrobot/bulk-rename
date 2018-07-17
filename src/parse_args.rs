use std::fmt;
use std::str::FromStr;
use std::error::Error;

#[derive(Debug)]
enum RenamerName {
    Insert,
    Remove,
}

impl fmt::Display for RenamerName {
    fn fmt(&self , f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:?}", self)
    }
}

#[derive(Debug)]
struct NoRenamerError {
    message: &'static str
}

impl FromStr for RenamerName {
    type Err = NoRenamerError;
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s.to_lowercase().as_str() {
            "insert" => Ok(RenamerName::Insert),
            "remove" => Ok(RenamerName::Remove),
            _ => Err(Self::Err{message: "no thing"}),
        }
    }
}

fn is_str_renamer(a: &str) -> bool {
    match RenamerName::from_str( a ) {
        Ok(renamer) => true,
        Err(_) => false
    }    
}

fn is_renamer_present(args: Vec<&str>) -> Option<&&str> {
    args.iter().find( |a| is_str_renamer(a) )
}

fn get_renamer(args: Vec<&str>) -> RenamerName {
    RenamerName::Insert
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_get_renamer() {
        let argv: Vec<&str> = vec!["foo", "bar", "baz", "insert", "qwe", "asd", "zxc"];
        let result = get_renamer(argv);
    }
}
