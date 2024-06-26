/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1; /* -b  option; if 0, dmenu appears at bottom     */
static int fuzzy = 1;
static int centered = 1;    /* -c option; centers dmenu on screen */
static int min_width = 500; /* minimum width when centered */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {"MononokiNerdFont-Regular.ttf:style:medium:size="
                              "12:antialias=true:autohint=true"};
#include "tokyonight.h"
// #include "zenburn.c"
static const char *prompt =
    NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
    /*     fg         bg       */
    [SchemeNorm] = {white, black},
    [SchemeSel] = {black, white},
    [SchemeSelHighlight] = {white, black2},
    [SchemeNormHighlight] = {yellow, black},
    [SchemeOut] = {"black", green},
    [SchemeOutHighlight] = {blue, red},
    [SchemeCursor] = {black, white},
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 12;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/*
 * -vi option; if nonzero, vi mode is always enabled and can be
 * accessed with the global_esc keysym + mod mask
 */
static unsigned int vi_mode = 1;
static unsigned int start_mode =
    0; /* mode to use when -vi is passed. 0 = insert mode, 1 = normal mode */
static Key global_esc = {
    XK_n, Mod1Mask}; /* escape key when vi mode is not enabled explicitly */
static Key quit_keys[] = {
    /* keysym	modifier */
    {XK_q, 0}};

/* Size of the window border */
static unsigned int border_width = 3;
