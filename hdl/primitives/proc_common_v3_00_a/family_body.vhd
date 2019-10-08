package body family is

      -- True if architecture "child" is derived from, or equal to,
      -- the architecture "ancestor".
      -- ANY, X4K, SPARTAN, SPARTANXL
      -- ANY, X4K, X4KE, X4KL
      -- ANY, X4K, X4KEX, X4KXL, X4KXV, X4KXLA
      -- ANY, VIRTEX, SPARTAN2, SPARTAN2E
      -- ANY, VIRTEX, VIRTEXE
      -- ANY, VIRTEX, VIRTEX2, BYZANTIUM
      -- ANY, VIRTEX, VIRTEX2, VIRTEX2P
      -- ANY, VIRTEX, VIRTEX2, SPARTAN3

  function derived ( child, ancestor : string ) return boolean is
    variable is_derived : boolean := FALSE;
  begin
    if equalIgnoreCase( child, VIRTEX ) then        -- base family type
      if ( equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, VIRTEX2 ) then
      if ( equalIgnoreCase(ancestor,VIRTEX2) OR
           equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, QRVIRTEX2 ) then
      if ( equalIgnoreCase(ancestor,QRVIRTEX2) OR
           equalIgnoreCase(ancestor,VIRTEX2) OR
           equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, QVIRTEX2 ) then
      if ( equalIgnoreCase(ancestor,QVIRTEX2) OR
           equalIgnoreCase(ancestor,VIRTEX2) OR
           equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, VIRTEX5 ) then
      if ( equalIgnoreCase(ancestor,VIRTEX5) OR
           equalIgnoreCase(ancestor,VIRTEX4) OR
           equalIgnoreCase(ancestor,VIRTEX2P) OR
           equalIgnoreCase(ancestor,VIRTEX2)  OR
           equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, VIRTEX4 ) then
      if ( equalIgnoreCase(ancestor,VIRTEX4) OR
           equalIgnoreCase(ancestor,VIRTEX2P) OR
           equalIgnoreCase(ancestor,VIRTEX2)  OR
           equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, VIRTEX2P ) then
      if ( equalIgnoreCase(ancestor,VIRTEX2P) OR
           equalIgnoreCase(ancestor,VIRTEX2)  OR
           equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, BYZANTIUM ) then
      if ( equalIgnoreCase(ancestor,BYZANTIUM) OR
           equalIgnoreCase(ancestor,VIRTEX2)   OR
           equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, VIRTEXE ) then
      if ( equalIgnoreCase(ancestor,VIRTEXE) OR
           equalIgnoreCase(ancestor,VIRTEX)  OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, SPARTAN2 ) then
      if ( equalIgnoreCase(ancestor,SPARTAN2) OR
           equalIgnoreCase(ancestor,VIRTEX)   OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, SPARTAN2E ) then
      if ( equalIgnoreCase(ancestor,SPARTAN2E) OR
           equalIgnoreCase(ancestor,SPARTAN2)  OR
           equalIgnoreCase(ancestor,VIRTEX)    OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, SPARTAN3 ) then
      if ( equalIgnoreCase(ancestor,SPARTAN3) OR
           equalIgnoreCase(ancestor,VIRTEX2)  OR
           equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, SPARTAN3E ) then
      if ( equalIgnoreCase(ancestor,SPARTAN3E) OR
           equalIgnoreCase(ancestor,SPARTAN3) OR
           equalIgnoreCase(ancestor,VIRTEX2)  OR
           equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, SPARTAN3A ) then
      if ( equalIgnoreCase(ancestor,SPARTAN3A) OR
           equalIgnoreCase(ancestor,SPARTAN3E) OR
           equalIgnoreCase(ancestor,SPARTAN3) OR
           equalIgnoreCase(ancestor,VIRTEX2)  OR
           equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, SPARTAN3AN ) then
      if ( equalIgnoreCase(ancestor,SPARTAN3AN) OR
           equalIgnoreCase(ancestor,SPARTAN3E) OR
           equalIgnoreCase(ancestor,SPARTAN3) OR
           equalIgnoreCase(ancestor,VIRTEX2)  OR
           equalIgnoreCase(ancestor,VIRTEX) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, X4K ) then        -- base family type
      if ( equalIgnoreCase(ancestor,X4K) OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, X4KEX ) then
      if ( equalIgnoreCase(ancestor,X4KEX) OR
           equalIgnoreCase(ancestor,X4K)   OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, X4KXL ) then
      if ( equalIgnoreCase(ancestor,X4KXL) OR
           equalIgnoreCase(ancestor,X4KEX) OR
           equalIgnoreCase(ancestor,X4K)   OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, X4KXV ) then
      if ( equalIgnoreCase(ancestor,X4KXV) OR
           equalIgnoreCase(ancestor,X4KXL) OR
           equalIgnoreCase(ancestor,X4KEX) OR
           equalIgnoreCase(ancestor,X4K)   OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, X4KXLA ) then
      if ( equalIgnoreCase(ancestor,X4KXLA) OR
           equalIgnoreCase(ancestor,X4KXV)  OR
           equalIgnoreCase(ancestor,X4KXL)  OR
           equalIgnoreCase(ancestor,X4KEX)  OR
           equalIgnoreCase(ancestor,X4K)    OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, X4KE ) then
      if ( equalIgnoreCase(ancestor,X4KE) OR
           equalIgnoreCase(ancestor,X4K)  OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, X4KL ) then
      if ( equalIgnoreCase(ancestor,X4KL) OR
           equalIgnoreCase(ancestor,X4KE) OR
           equalIgnoreCase(ancestor,X4K)  OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, SPARTAN ) then
      if ( equalIgnoreCase(ancestor,SPARTAN) OR
           equalIgnoreCase(ancestor,X4K)     OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, SPARTANXL ) then
      if ( equalIgnoreCase(ancestor,SPARTANXL) OR
           equalIgnoreCase(ancestor,SPARTAN)   OR
           equalIgnoreCase(ancestor,X4K)       OR
           equalIgnoreCase(ancestor,ANY)
         ) then is_derived := TRUE;
      end if;
    elsif equalIgnoreCase( child, ANY ) then
      if equalIgnoreCase( ancestor, any ) then is_derived := TRUE;
      end if;
    end if;

         return is_derived;
     end derived;


     -- Returns the lower case form of char if char is an upper case letter.
     -- Otherwise char is returned.
     function toLowerCaseChar( char : character ) return character is
     begin
        -- If char is not an upper case letter then return char
        if char < 'A' OR char > 'Z' then
          return char;
        end if;
        -- Otherwise map char to its corresponding lower case character and
        -- return that
        case char is
          when 'A' => return 'a';
          when 'B' => return 'b';
          when 'C' => return 'c';
          when 'D' => return 'd';
          when 'E' => return 'e';
          when 'F' => return 'f';
          when 'G' => return 'g';
          when 'H' => return 'h';
          when 'I' => return 'i';
          when 'J' => return 'j';
          when 'K' => return 'k';
          when 'L' => return 'l';
          when 'M' => return 'm';
          when 'N' => return 'n';
          when 'O' => return 'o';
          when 'P' => return 'p';
          when 'Q' => return 'q';
          when 'R' => return 'r';
          when 'S' => return 's';
          when 'T' => return 't';
          when 'U' => return 'u';
          when 'V' => return 'v';
          when 'W' => return 'w';
          when 'X' => return 'x';
          when 'Y' => return 'y';
          when 'Z' => return 'z';
          when others => return char;
        end case;
     end toLowerCaseChar;
      

     -- Returns true if case insensitive string comparison determines that
     -- str1 and str2 are equal
     function equalIgnoreCase( str1, str2 : string ) return boolean is
       constant LEN1 : integer := str1'length;
       constant LEN2 : integer := str2'length;
       variable equal : boolean := TRUE;
     begin
        if not (LEN1 = LEN2) then
          equal := FALSE;
        else
          for i in str1'range loop
            if not (toLowerCaseChar(str1(i)) = toLowerCaseChar(str2(i))) then
              equal := FALSE;
            end if;
          end loop;
        end if;

        return equal;
     end equalIgnoreCase;
      
 end package body family;
