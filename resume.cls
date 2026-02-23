\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2015/05/25 An elegant Résumé class]
\LoadClass[11pt]{article}

% disable indent globally
\setlength{\parindent}{0pt}
% some general improvements, defines the XeTeX logo
\RequirePackage{xltxtra}
% use xifthen
\RequirePackage{xifthen}
% use fontawesome
\RequirePackage{fontawesome}
% use xcolor for customizing color
\RequirePackage[usenames,dvipsnames]{xcolor}
% loading fonts
\RequirePackage{fontspec}
% Main document font
\setmainfont[
  Path = fonts/Main/ ,
  Extension = .otf ,
  UprightFont = *-regular ,
  BoldFont = *-bold ,
  ItalicFont = *-italic ,
  BoldItalicFont = *-bolditalic ,
  SmallCapsFont = Fontin-SmallCaps
]{texgyretermes}

\RequirePackage[
	a4paper,
	left=0.34in,
	right=0.34in,
	top=0.32in,
	bottom=0.32in,
	nohead
]{geometry}

\RequirePackage{titlesec}
\RequirePackage{enumitem}
\setlist{noitemsep} % removes spacing from items but leaves space around the whole list
%\setlist{nosep} % removes all vertical spacing within and around the list
\setlist[itemize]{topsep=0.25em, leftmargin=1.5pc}
\setlist[enumerate]{topsep=0.25em, leftmargin=1.5pc}
\RequirePackage[super]{nth}
\RequirePackage[colorlinks,allcolors=black,linkcolor=green,citecolor=green,urlcolor=black]{hyperref}
\RequirePackage{setspace}
\RequirePackage{eso-pic}

\titleformat{\section}         % Customise the \section command 
  {\Large\scshape\raggedright} % Make the \section headers large (\Large),
                               % small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
  {}                           % Can be used to insert code before the heading
  [\titlerule]                 % Inserts a horizontal line after the heading
\titlespacing*{\section}{0cm}{*1}{*1}

\titleformat{\subsection}
  {\large\raggedright}
  {}{0em}
  {}
\titlespacing*{\subsection}{0cm}{*1}{*0.5}

\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill #2}%
}
\newcommand{\datedsubsection}[2]{%
  \subsection[#1]{#1 \hfill #2}%
}
\newcommand{\eduexpsubsection}[2]{%
  \subsection[#1]{#1 \hfill #2}%
}
\newcommand{\datedline}[2]{%
  {\par #1 \hfill #2 \par}%
}

\newcommand{\projectsubsection}[3]{%
  \subsection[#1]{#1 \quad #2 \hfill #3}%
}

\newcommand{\name}[1]{
  \centerline{\Huge\scshape{#1}}
  \vspace{1.2ex}
}

\newcommand{\contactInfo}[4]{
  \centerline{\sffamily\large{\ {#1} \textperiodcentered\ \ {#2}}
    \ifthenelse{\isempty{#3}}%
      { } % if {#3} is empty
      {\textperiodcentered\ \ {#3} } % homepage, no space before \text...
    \ifthenelse{\isempty{#4}}%
      { } % if {#3} is empty
      {\textperiodcentered\ \ {#4} }
  }
  \vspace{0.7ex}
}

\newcommand{\role}[2]{
  {\par \textit{#1} ~ #2 \par}
  \vspace{0.5ex}
}

% ---------------------------------------------------------------------------
% Template-level shared config and helpers
% ---------------------------------------------------------------------------
% Watermark settings (override in template with \renewcommand).
\newcommand{\ResumeWatermarkText}{}
\newcommand{\ResumeWatermarkAngle}{35}
\newcommand{\ResumeWatermarkGray}{0.92}
\newcommand{\ResumeWatermarkFontSize}{48}
\newcommand{\resume@watermarknode}{%
  \rotatebox{\ResumeWatermarkAngle}{%
    \textcolor[gray]{\ResumeWatermarkGray}{%
      \fontsize{\ResumeWatermarkFontSize}{\ResumeWatermarkFontSize}\selectfont
      \textbf{\ResumeWatermarkText}%
    }%
  }%
}
\newcommand{\EnableResumeWatermark}{%
  \ifthenelse{\isempty{\ResumeWatermarkText}}{}{%
    \AddToShipoutPictureBG*{%
      \AtPageLowerLeft{%
        \put(\LenToUnit{0.50\paperwidth},\LenToUnit{0.72\paperheight}){\makebox(0,0){\resume@watermarknode}}%
        \put(\LenToUnit{0.50\paperwidth},\LenToUnit{0.28\paperheight}){\makebox(0,0){\resume@watermarknode}}%
      }%
    }%
  }%
}

% Icon / header layout settings (override in template with \renewcommand).
\newcommand{\CompanyIconDir}{icon}
\newcommand{\CompanyIconHeight}{1.15em}
\newcommand{\OrgTitleWidth}{4.5cm}
\newcommand{\InlineIconHeight}{1.0em}
\newcommand{\ContactIconWidth}{1.25em}
\newcommand{\ContactLabelWidth}{2.2em}
\newcommand{\ContactValueGap}{0.35em}
\newcommand{\ContactLabelSep}{：}

% Internal helper to resolve icon file path.
\newcommand{\resume@resolvedicon}{}
\newcommand{\resume@resolveicon}[1]{%
  \def\resume@resolvedicon{}%
  \IfFileExists{\CompanyIconDir/#1.png}{%
    \edef\resume@resolvedicon{#1.png}%
  }{%
    \IfFileExists{\CompanyIconDir/#1}{%
      \edef\resume@resolvedicon{#1}%
    }{}%
  }%
}

% Optional icon wrapper for \projectsubsection:
%   \projectsubsectionwithicon[icon-file]{title}{role}{date}
% If icon-file is empty, behaves exactly like \projectsubsection.
\newcommand{\projectsubsectionwithicon}[4][]{%
  \edef\companyiconfile{#1}%
  \ifx\companyiconfile\empty
    \projectsubsection{#2}{#3}{#4}%
  \else
    \resume@resolveicon{#1}%
    \ifx\resume@resolvedicon\empty
      \projectsubsection{#2}{#3}{#4}%
    \else
      \projectsubsection{%
        \raisebox{-0.2ex}{\includegraphics[height=\CompanyIconHeight]{\CompanyIconDir/\resume@resolvedicon}}%
        \hspace{0.35em}#2%
      }{#3}{#4}%
    \fi
  \fi
}

% Education heading with optional icon.
\newcommand{\edusubsectionwithicon}[3][]{%
  \edef\eduiconfile{#1}%
  \ifx\eduiconfile\empty
    \eduexpsubsection{#2}{#3}%
  \else
    \resume@resolveicon{#1}%
    \ifx\resume@resolvedicon\empty
      \eduexpsubsection{#2}{#3}%
    \else
      \eduexpsubsection{%
        \raisebox{-0.2ex}{\includegraphics[height=\CompanyIconHeight]{\CompanyIconDir/\resume@resolvedicon}}%
        \hspace{0.35em}#2%
      }{#3}%
    \fi
  \fi
}

% Unified heading format for project/internship entries.
% Optional arg controls the start position of the second field (#5).
\newcommand{\orgsubsection}[6][\OrgTitleWidth]{%
  \projectsubsectionwithicon[#2]{\textbf{\makebox[#1][l]{\href{#3}{\underline{#4}}}}}{#5}{#6}%
}

% Backward-compatible alias.
\newcommand{\internshipsubsection}[6][\OrgTitleWidth]{%
  \orgsubsection[#1]{#2}{#3}{#4}{#5}{#6}%
}

% Contact line layout (fixed icon/label columns for alignment).
\newcommand{\contactline}[3]{%
  \makebox[\ContactIconWidth][c]{#1}%
  \makebox[\ContactLabelWidth][l]{#2\ContactLabelSep}\hspace{\ContactValueGap}#3%
}

% Inline icon for footer/contact text.
\newcommand{\inlineicon}[1]{%
  \resume@resolveicon{#1}%
  \ifx\resume@resolvedicon\empty
  \else
    \raisebox{-0.2ex}{\includegraphics[height=\InlineIconHeight]{\CompanyIconDir/\resume@resolvedicon}}%
    \hspace{0.28em}%
  \fi
}
