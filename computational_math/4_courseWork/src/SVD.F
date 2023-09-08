      SUBROUTINE SVD(NM,M,N,A,W,MATU,U,MATV,V,IERR,RV1)
C
      INTEGER I,J,K,L,M,N,II,I1,KK,K1,LL,L1,MN,NM,ITS,IERR
      REAL A(NM,N),W(N),U(NM,N),V(NM,N),RV1(N)
C
      REAL C,F,G,H,S,X,Y,Z,SCALE,ANORM
      LOGICAL MATU,MATV
C
C     ÝTA ÏOÄÏPOÃPAMMA ECTÜ TPAHCËßÖÈß AËÃOË-ÏPOÖEÄÓPÛ SVD,
C     OÏÓÁËÈKOBAHHOÉ ÃOËÓÁOM È PAÉHØEM B ÆÓPHAËE NUMERISCHE
C     MATHEMATIK, 14, 403-420(1970), A TAKÆE B KHÈÃE
C     HANDBOOK FOR AUTOMATIC COMPUTATION  VOL.II-LINEAR
C     ALGEBRA, 134-151 (1971).
C
C     ÝTA ÏOÄÏPOÃPAMMA BÛ×ÈCËßET CÈHÃÓËßPHOE PAÇËOÆEHÈE
C          T
C     A=USV  ÄEÉCTBÈTEËÜHOÉ ÏPßMOÓÃOËÜHOÉ MATPÈÖÛ A C PAÇME-
C     PAMÈ M È N. ÏPÈ ÝTOM ÈCÏOËÜÇÓÞTCß ÄBÓXÄÈAÃOHAËÈÇAÖÈß
C     ÏOCPEÄCTBOM XAÓCXOËÄEPOBÛX OTPAÆEHÈÉ  È BAPÈAHT
C     QR-AËÃOPÈTMA.
C
C     HA BXOÄE.
C
C     NM   CËEÄÓET ÏOËOÆÈTÜ PABHÛM CTPO×HOÉ PAÇMEPHOCTÈ
C          ÄBÓXMEPHÛX MACCÈBOB ,ÇAßBËEHHOÉ B OÏEPATOPE PAÇ-
C          MEPHOCTÈ BÛÇÛBAÞÙEÉ ÏPOÃPAMMÛ. ÇAMETÈM, ×TO NM
C          ÄOËÆHO ÁÛTÜ H  MEHÜØE,×EM MAKCÈMÓM ÈÇ M È N.
C
C     M    ×ÈCËO CTPOK A (È U).
C
C     N    ×ÈCËO CTOËÁÖOB A (È U) È ÏOPßÄOK V.
C
C     A    COÄEPÆÈT ÏPßMOÓÃOËÜHÓÞ BXOÄHÓÞ MATPÈÖÓ, ÄËß
C          KOTOPOÉ HAXOÄÈTCß  PAÇËOÆEHÈE.
C
C     MATU ÄOËÆEH ÈMETÜ ÇHA×EHÈE .TRUE., ECËÈ HÓÆHO
C          BÛ×ÈCËßTÜ MATPÈÖÓ U ÈÇ PAÇËOÆEHÈß, È ÇHA×EHÈE
C          .FALSE. B ÏPOTÈBHOM CËÓ×AE.
C
C     MATV ÄOËÆEH ÈMETÜ ÇHA×EHÈE .TRUE., ECËÈ HÓÆHO
C          BÛ×ÈCËßTÜ MATPÈÖÓ V ÈÇ PAÇËOÆEHÈß, È ÇHA×EHÈE
C          .FALSE. B ÏPOTÈBHOM CËÓ×AE.
C
C     HA BÛXOÄE.
C
C     A    HE ÈÇMEHßETCß (ECËÈ HA EE MECTE HE ÇAÏÈCÛBAÞTCß
C          U ËÈÁO V).
C
C     W    COÄEPÆÈT N (HEOTPÈÖATEËÜHÛX) CÈHÃÓËßPHÛX ×ÈCEË
C          A (ÄÈAÃOHAËÜHÛX ÝËEMEHTOB S). OHÈ HE ÓÏOPßÄO×EHÛ.
C          ECËÈ ÏPOÈCXOÄÈT BÛXOÄ ÏO OØÈÁKE, TO ÄËß ÇHA×EHÈÉ
C          IERR+1, IERR+2,...,N CÈHÃÓ ËßPHÛE ×ÈCËA ÄOËÆHÛ
C          ÁÛTÜ BEPHÛ.
C
C     U    COÄEPÆÈT MATPÈÖÓ U (C OPTOÃOHAËÜHÛMÈ CTOËÁÖAMÈ)
C          ÈÇ PAÇËOÆEHÈß, ECËÈ ÄËß ÏAPAMETPA MATU ÁÛËO
C          ÇAÄAHO ÇHA×EHÈE .TRUE. B ÏPOTÈBHOM CËÓ×AE HA U
C          ÈCÏOËÜÇÓETCß KAK BPEMEHHÛÉ MACCÈB. U TAKÆE MOÆET
C          COBÏAÄATÜ C A. ECËÈ ÏPOÈCXOÄÈT BÛXOÄ
C          ÏO OØÈÁKE, TO CTOËÁÖÛ U, COOTBETCTBÓÞÙÈE ÈHÄEKCAM
C          BEPHÛX CÈHÃÓËßPHÛX ×ÈCEË, ÄOËÆHÛ ÁÛTÜ TAKÆE BEPHÛ.
C
C     V    COÄEPÆÈT MATPÈÖÓ V (OPTOÃOHAËÜHÓÞ) ÈÇ PAÇËOÆEHÈß,
C          ECËÈ ÄËß ÏAPAMETPA MATV ÁÛËO ÇAÄAHO ÇHA×EHÈE
C          .TRUE. B ÏPOTÈBHOM CËÓ×AE HA V HE ÏPOÈÇBOÄÈTCß
C          CCÛËOK. V TAKÆE MOÆET COBÏAÄATÜ C  A, ECËÈ U HE
C          BÛ×ÈCËßETCß. ECËÈ ÏPOÈCXOÄÈT BÛXOÄ ÏO OØÈÁKE,
C          TO CTOËÁÖÛ V, COOTBETCTBÓÞÙÈE ÈHÄEKCAM BEPHÛX
C          CÈHÃÓËßPHÛX ×ÈCEË, ÄOËÆHÛ ÁÛTÜ TAKÆE BEPHÛ.
C
C     IERR PABHO
C            0,  ECËÈ ÏPOÈCXOÄÈT HOPMAËÜHÛÉ BÛXOÄ ÈÇ ÏOÄÏPOÃ-
C                PAMMÛ,
C            K,  ECËÈ K-E CÈHÃÓËßPHOE ×ÈCËO HE ÁÛËO OÏPEÄE-
C                ËEHO ÏOCËE 30 ÈTEPAÖÈÉ.
C
C     RV1  ÝTO MACCÈB ÏPOMEÆÓTO×HOÃO XPAHEHÈß.
C
C     BOÏPOCÛ È KOMMEHTAPÈÈ HÓÆHO HAÏPABËßTÜ ÏO AÄPECÓ
C     B.S.GARBOW, APPLIED MATEMATICS DIVISION, ARGONNE
C     NATIONAL LABORATORY
C
C     ÏOÄÏPOÃPAMMA MOÄÈÔÈÖÈPOBAHA C ÖEËÜÞ ÈCKËÞ×ÈTÜ
C     ÏEPEMEHHYÞ MACHEP
C
      IERR=0
      DO 100 I=1,M
      DO 100 J=1,N
      U(I,J)=A(I,J)
  100 CONTINUE
C
C     XAÓCXOËÄEPOBO ÏPÈBEÄEHÈE K ÄBÓXÄÈAÃOHAËÜHOÉ ÔOPME
C
      G=0.0
      SCALE=0.0
      ANORM=0.0
C
      DO 300 I=1,N
         L=I+1
         RV1(I)=SCALE*G
         G=0.0
         S=0.0
         SCALE=0.0
         IF(I.GT.M)GO TO 210
C
         DO 120 K=I,M
  120       SCALE=SCALE+ABS(U(K,I))
         IF(SCALE.EQ.0.0)GO TO 210
C
         DO 130 K=I,M
            U(K,I)=U(K,I)/SCALE
            S=S+U(K,I)**2
  130    CONTINUE
C
         F=U(I,I)
         G=-SIGN(SQRT(S),F)
         H=F*G-S
         U(I,I)=F-G
         IF(I.EQ.N)GO TO 190
C
         DO 150 J=L,N
            S=0.0
            DO 140 K=I,M
  140          S=S+U(K,I)*U(K,J)
               F=S/H
            DO 150 K=I,M
               U(K,J)=U(K,J)+F*U(K,I)
  150    CONTINUE
C
  190    DO 200 K=I,M
  200       U(K,I)=SCALE*U(K,I)
  210    W(I)=SCALE*G
         G=0.0
         S=0.0
         SCALE=0.0
         IF(I.GT.M.OR.I.EQ.N)GO TO 290
C
         DO 220 K=L,N
  220       SCALE=SCALE+ABS(U(I,K))
C
         IF(SCALE.EQ.0.0)GO TO 290
C
         DO 230 K=L,N
            U(I,K)=U(I,K)/SCALE
            S=S+U(I,K)**2
  230    CONTINUE
C
         F=U(I,L)
         G=-SIGN(SQRT(S),F)
         H=F*G-S
         U(I,L)=F-G
C
         DO 240 K=L,N
  240       RV1(K)=U(I,K)/H
C
         IF(I.EQ.M)GO TO 270
C
         DO 260 J=L,M
            S=0.0
            DO 250 K=L,N
  250          S=S+U(J,K)*U(I,K)
            DO 260 K=L,N
               U(J,K)=U(J,K)+S*RV1(K)
  260    CONTINUE
C
  270    DO 280 K=L,N
  280    U(I,K)=SCALE*U(I,K)
C
  290    ANORM=AMAX1(ANORM,ABS(W(I))+ABS(RV1(I)))
  300 CONTINUE
C
C     HAKOÏËEHÈE ÏPABOCTOPOHHÈX ÏPEOÁPAÇOBAHÈÉ
C
      IF(.NOT.MATV)GO TO 410
C
C     ÄËß I=N C ØAÃOM -1 ÄO 1 BÛÏOËHÈTÜ -
C
      DO 400 II=1,N
         I=N+1-II
         IF(I.EQ.N)GO TO 390
         IF(G.EQ.0.0)GO TO 360
C
         DO 320 J=L,N
C
C     ÄBOÉHOE ÄEËEHÈE OÁXOÄÈT BOÇMOÆHÛÉ MAØÈHHÛÉ HYËÜ
C
  320    V(J,I)=(U(I,J)/U(I,L))/G
C
         DO 350 J=L,N
            S=0.0
            DO 340 K=L,N
  340       S=S+U(I,K)*V(K,J)
            DO 350 K=L,N
            V(K,J)=V(K,J)+S*V(K,I)
  350 CONTINUE
C
  360    DO 380 J=L,N
            V(I,J)=0.0
            V(J,I)=0.0
  380    CONTINUE
C
  390    V(I,I)=1.0
         G=RV1(I)
         L=I
  400 CONTINUE
C
C     HAKOÏËEHÈE ËEBOCTOPOHHÈX ÏPEOÁPAÇOBAHÈÉ
C
  410 IF(.NOT.MATU)GO TO 510
C
C     ÄËß I=MIN(N,M) C ØAÃOM -1 ÄO 1 BÛÏOËHÈTÜ-
C
      MN=N
      IF(M.LT.N)MN=M
C
      DO 500 II=1,MN
         I=MN+1-II
         L=I+1
         G=W(I)
         IF(I.EQ.N)GO TO 430
C
         DO 420 J=L,N
  420    U(I,J)=0.0
C
  430    IF(G.EQ.0.0)GO TO 475
         IF(I.EQ.MN)GO TO 460
C
         DO 450 J=L,N
            S=0.0
            DO 440 K=L,M
  440       S=S+U(K,I)*U(K,J)
C
C     ÄBOÉHOE  ÄEËEHÈE OÁXOÄÈT BOÇMOÆHÛÉ MAØÈHHÛÉ HYËÜ
C
            F=(S/U(I,I))/G
C
            DO 450 K=I,M
               U(K,J)=U(K,J)+F*U(K,I)
  450    CONTINUE

  460    DO 470 J=I,M
  470    U(J,I)=U(J,I)/G
C
         GO TO 490
C
  475    DO 480 J=I,M
  480    U(J,I)=0.0
C
  490    U(I,I)=U(I,I)+1.0
  500 CONTINUE
C
C     ÄÈAÃOHAËÈÇAÖÈß ÄBÓXÄÈAÃOHAËÜHOÉ ÔOPMÛ ÄËß K=N C ØAÃOM
C     -1 ÄO 1 BÛÏOËHÈTÜ
C
  510 DO 700 KK=1,N
         K1=N-KK
         K=K1+1
         ITS=0
C
C     ÏPOBEPKA BOÇMOÆHOCTÈ PACÙEÏËEHÈß  ÄËß L=K
C     C ØAÃOM -1 ÄO 1 BÛÏOËHÈTÜ
C
  520    DO 530 LL=1,K
            L1=K-LL
            L=L1+1
            IF(ABS(RV1(L))+ANORM.EQ.ANORM)GO TO 565
C
C     RV1(1) BCEÃÄA PABHO HÓËÞ. ÏOÝTOMÓ BÛXOÄA
C     ×EPEÇ KOHEÖ ÖÈKËA HE ÁÓÄET
C
            IF(ABS(W(L1))+ANORM.EQ.ANORM)GO TO 540
  530    CONTINUE
C
C      ECËÈ L ÁOËÜØE, ×EM 1, TO RV1(L)
C      ÏPÈCBAÈBAETCß HÓËEBOE ÇHA×EHÈE
C
  540    C=0.0
         S=1.0
C
         DO 560 I=L,K
            F=S*RV1(I)
            RV1(I)=C*RV1(I)
            IF(ABS(F)+ANORM.EQ.ANORM)GO TO 565
            G=W(I)
            H=SQRT(F*F+G*G)
            W(I)=H
            C=G/H
            S=-F/H
            IF(.NOT.MATU)GO TO 560
C
            DO 550 J=1,M
               Y=U(J,L1)
               Z=U(J,I)
               U(J,L1)=Y*C+Z*S
               U(J,I)=-Y*S+Z*C
  550       CONTINUE
  560    CONTINUE
C
C     ÏPOBEPKA CXOÄÈMOCTÈ
C
  565    Z=W(K)
         IF(L.EQ.K)GO TO 650
C
C     CÄBÈÃ BÛÁÈPAETCß ÈÇ HÈÆHEÃO ÓÃËOBOÃO
C     MÈHOPA ÏOPßÄKA 2
C
         IF(ITS.EQ.30)GO TO 1000
         ITS=ITS+1
         X=W(L)
         Y=W(K1)
         G=RV1(K1)
         H=RV1(K)
         F=((Y-Z)*(Y+Z)+(G-H)*(G+H))/(2.0*H*Y)
         G=SQRT(F*F+1.0)
         F=((X-Z)*(X+Z)+H*(Y/(F+SIGN(G,F))-H))/X
C
C     CËEÄÓÞÙEE QR-ÏPEOÁPAÇOBAHÈE
C
         C=1.0
         S=1.0
C
         DO 600 I1=L,K1
            I=I1+1
            G=RV1(I)
            Y=W(I)
            H=S*G
            G=C*G
            Z=SQRT(F*F+H*H)
            RV1(I1)=Z
            C=F/Z
            S=H/Z
            F=X*C+G*S
            G=-X*S+G*C
            H=Y*S
            Y=Y*C
            IF(.NOT.MATV)GO TO 575
C
            DO 570 J=1,N
               X=V(J,I1)
               Z=V(J,I)
               V(J,I1)=X*C+Z*S
               V(J,I)=-X*S+Z*C
  570       CONTINUE
C
  575       Z=SQRT(F*F+H*H)
            W(I1)=Z
C
C     BPAÙEHÈE MOÆET ÁÛTÜ ÏPOÈÇBOËÜHÛM, ECËÈ Z PABHO HÓËÞ
C
            IF(Z.EQ.0.0)GO TO 580
            C=F/Z
            S=H/Z
  580       F=C*G+S*Y
            X=-S*G+C*Y
            IF(.NOT.MATU)GO TO 600
C
            DO 590 J=1,M
               Y=U(J,I1)
               Z=U(J,I)
               U(J,I1)=Y*C+Z*S
               U(J,I)=-Y*S+Z*C
  590       CONTINUE
  600    CONTINUE
         RV1(L)=0.0
         RV1(K)=F
         W(K)=X
         GO TO 520
C
C     CXOÄÈMOCTÜ
C
  650    IF(Z.GE.0.0)GO TO 700
C
C     W(K) ÄEËAETCß HEOTPÈÖATEËÜHÛM
C
         W(K)=-Z
         IF(.NOT.MATV)GO TO 700
C
         DO 690 J=1,N
  690    V(J,K)=-V(J,K)
  700 CONTINUE
      GO TO 1001
C
C     ÓCTAHOBÈTÜ ÇHA×EHÈE ÏPÈÇHAKA OØÈÁKÈ - ÏOCËE 30
C     ÈTEPAÖÈÉ HET CXOMOCTÈ K CÈHÃÓËßPHOMÓ ×ÈCËÓ
C
 1000 IERR=K
 1001 RETURN
      END
