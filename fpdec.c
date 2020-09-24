/*
 * Filename: fpdec.c
 * Author: Qixuan "Harrison" Ma
 * UserID: cs30s220bn
 * Date: September 3 2020
 * Sources of Help: Piazza posts and the PA3 writeup
 */ 

#include "pa3.h"
#include "pa3Strings.h" 
#include <stdio.h> 
#include <stdlib.h> 
#include <string.h>

/*
 * Function Name: int main
 * Function Prototype: int main( int argc, char * argv[] ); 
 * Description: This is the main driver of the program. It parses the command 
 *              line arguments, build the struct of IEEE-754 floating point
 *              parts, and print out the struct's members. 
 * Parameters: int argc: the number of inputs
 *             char * argv: the inputs of the function in strings
 * Side Effects: None 
 * Error Conditions: If an invalid number of arguments is passed in, 
 *                   there would be a error condition
 * Return Value: Return 0 if the program executes successfully
 */

int main( int argc, char * argv[] )
{
  // if the number of arguments is invalid, return immediately 
  if( argc != 3 ) 
  {
    fprintf( stderr, INVALID_ARGS ); 
    fprintf( stderr, SHORT_USAGE ); 
    return EXIT_FAILURE; 
  }

  char * origNum = argv[2]; 
  char * str[3] = {0,1,origNum}; 
  unsigned long parsedNum = parseNum( str ); 

  // check if the first argv is -s
  if( strcmp(argv[1], "-s") == 0)
  {
    // instantiate struct on the stack 
    ieeeParts_t numParts; 
    extractParts( parsedNum, &numParts ); 
  
    printf( SIGN_STR, numParts.sign ); 
    printf( EXP_STR, numParts.exp ); 
    printf( MANTISSA_STR, numParts.mantissa ); 
  }
  // if the first argv is not -s, assume it is -h 
  else
  {
    // instantiate struct on the heap 
    ieeeParts_t * numParts = malloc( sizeof( struct fpbits ) );
    extractParts( parsedNum, numParts );

    printf( SIGN_STR, numParts->sign ); 
    printf( EXP_STR, numParts->exp ); 
    printf( MANTISSA_STR, numParts->mantissa ); 
    
    free( numParts ); 
  }

  return EXIT_SUCCESS; 
}
