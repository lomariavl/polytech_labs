      REAL FUNCTION URAND(IY)
      INTEGER IY
C
C       URAND-�TO �AT��K PABHOMEPHO PAC�PE�E�EHH�X C���A�H�X
C     ��CE�, OCHOBAHH�� HA TEOP�� � �PE��O�EH��X, CO�EP�A��XC�
C     B KH��E KH�T (1969),TOM 2.
C       �EPE� �EPB�M O�PA�EH�EM K URAND �E�O� �EPEMEHHO� IY
C     C�E��ET �P�CBO�T� �PO��BO��HOE �E�O��C�EHHOE HA�A��-
C     HOE �HA�EH�E. B���BA��A� �PO�PAMMA HE �O��HA ��MEH�T�
C     �HA�EH�E IY ME��� �OC�E�OBATE��H�M� B��OBAM�. �HA�EH��
C     ��HK��� URAND �B���TC� ��C�AM� �� �HTEPBA�A (0,1).
C
      INTEGER IA,IC,ITWO,M2,M,MIC
      DOUBLE PRECISION HALFM
      REAL S
      DOUBLE PRECISION DATAN,DSQRT
      DATA M2/0/,ITWO/2/
      IF(M2.NE.0) GOTO 20
C
C     EC�� �TO �EPB�� BXO�, TO B���C��T� ���H�
C     �E�O��C�EHHO�O MA��HHO�O C�OBA
C
      M=1
   10 M2=M
      M=ITWO*M2
      IF(M .GT. M2) GO TO 10
      HALFM=M2
C
C     B���C��T� MHO��TE�� � �P�PA�EH�E ��HE�HO�O
C     KOH�P��HTHO�O METO�A
C
      IA=8*IDINT(HALFM*DATAN(1.D0)/8.D0)+5
      IC=2*IDINT(HALFM*(0.5D0-DSQRT(3.D0)/6.D0))+1
      MIC=(M2-IC)+M2
C
C     S-MAC�TA��P����� MHO��TE�� ��� �PEO�PA�OBAH�� B ��C�O
C     C ��ABA��E� TO�KO�
C
      S=0.5/HALFM
C
C     B���C��T� C�E����EE C���A�HOE ��C�O
C
   20 IY=IY*IA
C
C     C�E������ O�EPATOP-��� MA��H,KOTOP�E HE �O��CKA�T
C     �EPE�O�HEH�� �E��X ��CE� �P� C�O�EH��
C
      IF(IY.GT.MIC) IY=(IY-M2)-M2
      IY=IY+IC
C
C     C�E������ O�EPATOP - ��� MA��H, � KOTOP�X ���HA C�OBA
C     ��� C�O�EH�� �O���E, �EM ��� �MHO�EH��
C
      IF(IY/2.GT.M2) IY=(IY-M2)-M2
C
C     C�E������ O�EPATOP - ��� MA��H, � KOTOP�X �EPE�O�HEH�E
C     �E�O�O ��C�A B���ET HA �HAKOB�� PA�P��
C
      IF(IY.LT.0) IY=(IY+M2)+M2
      URAND=FLOAT(IY)*S
      RETURN
      END
