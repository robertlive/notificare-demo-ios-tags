//
//  Definitions.h
//  TheApp
//
//  Created by Joel Oliveira on 7/16/13.
//  Copyright (c) 2013 Notificare. All rights reserved.
//

#ifndef mangroveapp_Definitions_h
#define mangroveapp_Definitions_h

/**
 * UI STUFF
 */
#define DEFAULT_FONTSIZE    15
#define LATO_FONT(s)     [UIFont fontWithName:@"Lato-Regular" size:s]
#define ARVO_FONT(s)     [UIFont fontWithName:@"Arvo" size:s]
#define MUSEO_FONT(s)    [UIFont fontWithName:@"Museo" size:s]
#define OLEO_FONT(s)     [UIFont fontWithName:@"OleoScript" size:s]

#define DEFAULT_CELLHEIGHT  80
#define MENU_CELLHEIGHT  40
#define INVITES_CELLHEIGHT  40
#define MESSAGES_CELLHEIGHT  60

#define DEFAULT_HEADER_HEIGHT 30
#define MENU_HEADER_HEIGHT 30
/**
 * LOC STRINGS
 */
#define LSSTRING(str) NSLocalizedString(str, str)

/**
 * DIALOGS
 */
#define ALERT_DIALOG(__title__,__message__) \
do\
{\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:(__title__) message:(__message__) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];\
[alert show];\
} while ( 0 )


#define CONFIRM_DIALOG(__title__,__message__) \
do\
{\
UIAlertView *confirm = [[UIAlertView alloc] initWithTitle:(__title__) message:(__message__) delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];\
[confirm show];\
} while ( 0 )


/**
 * DEBUG
 */
#ifdef DEBUG
#   define XLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define XLog(...)
#endif

#define ZLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)




#endif
