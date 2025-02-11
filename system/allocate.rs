pub struct Allocate<'a> {
    /// Account to be assigned.
    pub account: &'a AccountInfo,

    /// Number of bytes of memory to allocate.
    pub space: u64,
}

impl Allocate<'_> {
    #[inline(always)]
    pub fn invoke(&self) -> ProgramResult {
        self.invoke_signed(&[])
    }
