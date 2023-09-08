      REAL FUNCTION URAND(IY)
      INTEGER IY
C
C       URAND-ÝTO ÄAT×ÈK PABHOMEPHO PACÏPEÄEËEHHÛX CËÓ×AÉHÛX
C     ×ÈCEË, OCHOBAHHÛÉ HA TEOPÈÈ È ÏPEÄËOÆEHÈßX, COÄEPÆAÙÈXCß
C     B KHÈÃE KHÓT (1969),TOM 2.
C       ÏEPEÄ ÏEPBÛM OÁPAÙEHÈEM K URAND ÖEËOÉ ÏEPEMEHHOÉ IY
C     CËEÄÓET ÏPÈCBOÈTÜ ÏPOÈÇBOËÜHOE ÖEËO×ÈCËEHHOE HA×AËÜ-
C     HOE ÇHA×EHÈE. BÛÇÛBAÞÙAß ÏPOÃPAMMA HE ÄOËÆHA ÈÇMEHßTÜ
C     ÇHA×EHÈE IY MEÆÄÓ ÏOCËEÄOBATEËÜHÛMÈ BÛÇOBAMÈ. ÇHA×EHÈß
C     ÔÓHKÖÈÈ URAND ßBËßÞTCß ×ÈCËAMÈ ÈÇ ÈHTEPBAËA (0,1).
C
      INTEGER IA,IC,ITWO,M2,M,MIC
      DOUBLE PRECISION HALFM
      REAL S
      DOUBLE PRECISION DATAN,DSQRT
      DATA M2/0/,ITWO/2/
      IF(M2.NE.0) GOTO 20
C
C     ECËÈ ÝTO ÏEPBÛÉ BXOÄ, TO BÛ×ÈCËÈTÜ ÄËÈHÓ
C     ÖEËO×ÈCËEHHOÃO MAØÈHHOÃO CËOBA
C
      M=1
   10 M2=M
      M=ITWO*M2
      IF(M .GT. M2) GO TO 10
      HALFM=M2
C
C     BÛ×ÈCËÈTÜ MHOÆÈTEËÜ È ÏPÈPAÙEHÈE ËÈHEÉHOÃO
C     KOHÃPÓÝHTHOÃO METOÄA
C
      IA=8*IDINT(HALFM*DATAN(1.D0)/8.D0)+5
      IC=2*IDINT(HALFM*(0.5D0-DSQRT(3.D0)/6.D0))+1
      MIC=(M2-IC)+M2
C
C     S-MACØTAÁÈPÓÞÙÈÉ MHOÆÈTEËÜ ÄËß ÏPEOÁPAÇOBAHÈß B ×ÈCËO
C     C ÏËABAÞÙEÉ TO×KOÉ
C
      S=0.5/HALFM
C
C     BÛ×ÈCËÈTÜ CËEÄÓÞÙEE CËÓ×AÉHOE ×ÈCËO
C
   20 IY=IY*IA
C
C     CËEÄÓÞÙÈÉ OÏEPATOP-ÄËß MAØÈH,KOTOPÛE HE ÄOÏÓCKAÞT
C     ÏEPEÏOËHEHÈß ÖEËÛX ×ÈCEË ÏPÈ CËOÆEHÈÈ
C
      IF(IY.GT.MIC) IY=(IY-M2)-M2
      IY=IY+IC
C
C     CËEÄÓÞÙÈÉ OÏEPATOP - ÄËß MAØÈH, Ó KOTOPÛX ÄËÈHA CËOBA
C     ÄËß CËOÆEHÈß ÁOËÜØE, ×EM ÄËß ÓMHOÆEHÈß
C
      IF(IY/2.GT.M2) IY=(IY-M2)-M2
C
C     CËEÄÓÞÙÈÉ OÏEPATOP - ÄËß MAØÈH, Ó KOTOPÛX ÏEPEÏOËHEHÈE
C     ÖEËOÃO ×ÈCËA BËÈßET HA ÇHAKOBÛÉ PAÇPßÄ
C
      IF(IY.LT.0) IY=(IY+M2)+M2
      URAND=FLOAT(IY)*S
      RETURN
      END
