PGDMP         6                |           reft    12.17    12.17 A    k           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            l           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            m           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            n           1262    33689    reft    DATABASE     �   CREATE DATABASE reft WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE reft;
                reftreft    false            �           1247    74168 	   book_type    TYPE     l   CREATE TYPE public.book_type AS (
	hourdays "char",
	dayshours "char",
	dayhours "char",
	onehour "char"
);
    DROP TYPE public.book_type;
       public          reftreft    false            �           1247    41326    check_status    TYPE     E   CREATE TYPE public.check_status AS ENUM (
    'false',
    'true'
);
    DROP TYPE public.check_status;
       public          reftreft    false            �           1247    41098 
   checkadmin    TYPE     C   CREATE TYPE public.checkadmin AS ENUM (
    'false',
    'true'
);
    DROP TYPE public.checkadmin;
       public          reftreft    false            �           1247    33813 
   rolechoose    TYPE     d   CREATE TYPE public.rolechoose AS ENUM (
    'TEACHER',
    'OWNER',
    'admin_1/id=80226753244'
);
    DROP TYPE public.rolechoose;
       public          reftreft    false            �           1247    33820    verifychoose    TYPE     E   CREATE TYPE public.verifychoose AS ENUM (
    'false',
    'true'
);
    DROP TYPE public.verifychoose;
       public          reftreft    false            �            1259    57940    hall    TABLE     I  CREATE TABLE public.hall (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    capacity character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    price_hour character varying(255) NOT NULL,
    location character varying(255) NOT NULL,
    details text NOT NULL,
    images character varying(2000)[] NOT NULL,
    cover_image character varying(500) NOT NULL,
    pdf character varying(500) NOT NULL,
    video character varying(500) NOT NULL,
    user_id integer NOT NULL,
    checked public.check_status DEFAULT 'false'::public.check_status
);
    DROP TABLE public.hall;
       public         heap    reftreft    false    655    655            �            1259    57957 	   hall_book    TABLE     2  CREATE TABLE public.hall_book (
    id integer NOT NULL,
    user_id integer NOT NULL,
    hall_id integer NOT NULL,
    date date DEFAULT CURRENT_DATE,
    day integer NOT NULL,
    month integer NOT NULL,
    year integer NOT NULL,
    code character varying(255) NOT NULL,
    hour character varying
);
    DROP TABLE public.hall_book;
       public         heap    reftreft    false            �            1259    74340    hall_book_dashboard    TABLE     �  CREATE TABLE public.hall_book_dashboard (
    id integer NOT NULL,
    user_id integer NOT NULL,
    hall_id integer NOT NULL,
    halluser_id integer NOT NULL,
    datefrom date,
    dateto date,
    hourfrom time without time zone,
    hourto time without time zone,
    date date,
    type character varying(50) NOT NULL,
    amount numeric NOT NULL,
    onehour time without time zone
);
 '   DROP TABLE public.hall_book_dashboard;
       public         heap    reftreft    false            �            1259    74338    hall_book_dashboard_id_seq    SEQUENCE     �   CREATE SEQUENCE public.hall_book_dashboard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.hall_book_dashboard_id_seq;
       public          reftreft    false    216            o           0    0    hall_book_dashboard_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.hall_book_dashboard_id_seq OWNED BY public.hall_book_dashboard.id;
          public          reftreft    false    215            �            1259    57955    hall_book_id_seq    SEQUENCE     �   CREATE SEQUENCE public.hall_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.hall_book_id_seq;
       public          reftreft    false    211            p           0    0    hall_book_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.hall_book_id_seq OWNED BY public.hall_book.id;
          public          reftreft    false    210            �            1259    57938    hall_id_seq    SEQUENCE     �   CREATE SEQUENCE public.hall_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.hall_id_seq;
       public          reftreft    false    209            q           0    0    hall_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.hall_id_seq OWNED BY public.hall.id;
          public          reftreft    false    208            �            1259    74172    hallrate    TABLE     t   CREATE TABLE public.hallrate (
    hallid integer,
    userid integer,
    id integer NOT NULL,
    rate integer
);
    DROP TABLE public.hallrate;
       public         heap    reftreft    false            �            1259    74201    hallrate_id_seq    SEQUENCE     �   ALTER TABLE public.hallrate ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.hallrate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          reftreft    false    213            �            1259    33692 
   migrations    TABLE     �   CREATE TABLE public.migrations (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    run_on timestamp without time zone NOT NULL
);
    DROP TABLE public.migrations;
       public         heap    reftreft    false            �            1259    33690    migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public          reftreft    false    203            r           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public          reftreft    false    202            �            1259    57924    user_message    TABLE     �   CREATE TABLE public.user_message (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    phone character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    message text NOT NULL,
    user_id integer NOT NULL
);
     DROP TABLE public.user_message;
       public         heap    reftreft    false            �            1259    57922    user_message_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.user_message_id_seq;
       public          reftreft    false    207            s           0    0    user_message_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.user_message_id_seq OWNED BY public.user_message.id;
          public          reftreft    false    206            �            1259    57906    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password text NOT NULL,
    name character varying(255) NOT NULL,
    phone character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    role public.rolechoose DEFAULT 'OWNER'::public.rolechoose,
    profile_img character varying(255) DEFAULT NULL::character varying,
    password_changed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    password_verified_code character varying(255) DEFAULT 'undefined'::character varying,
    password_reset_expires timestamp without time zone,
    reset_code_verified public.verifychoose DEFAULT 'false'::public.verifychoose
);
    DROP TABLE public.users;
       public         heap    reftreft    false    646    649    649    646            �            1259    57904    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          reftreft    false    205            t           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          reftreft    false    204            �
           2604    57943    hall id    DEFAULT     b   ALTER TABLE ONLY public.hall ALTER COLUMN id SET DEFAULT nextval('public.hall_id_seq'::regclass);
 6   ALTER TABLE public.hall ALTER COLUMN id DROP DEFAULT;
       public          reftreft    false    209    208    209            �
           2604    57960    hall_book id    DEFAULT     l   ALTER TABLE ONLY public.hall_book ALTER COLUMN id SET DEFAULT nextval('public.hall_book_id_seq'::regclass);
 ;   ALTER TABLE public.hall_book ALTER COLUMN id DROP DEFAULT;
       public          reftreft    false    211    210    211            �
           2604    74343    hall_book_dashboard id    DEFAULT     �   ALTER TABLE ONLY public.hall_book_dashboard ALTER COLUMN id SET DEFAULT nextval('public.hall_book_dashboard_id_seq'::regclass);
 E   ALTER TABLE public.hall_book_dashboard ALTER COLUMN id DROP DEFAULT;
       public          reftreft    false    215    216    216            �
           2604    33695    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public          reftreft    false    203    202    203            �
           2604    57927    user_message id    DEFAULT     r   ALTER TABLE ONLY public.user_message ALTER COLUMN id SET DEFAULT nextval('public.user_message_id_seq'::regclass);
 >   ALTER TABLE public.user_message ALTER COLUMN id DROP DEFAULT;
       public          reftreft    false    206    207    207            �
           2604    57909    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          reftreft    false    205    204    205            b          0    57940    hall 
   TABLE DATA           �   COPY public.hall (id, name, capacity, city, price_hour, location, details, images, cover_image, pdf, video, user_id, checked) FROM stdin;
    public          reftreft    false    209   �O       d          0    57957 	   hall_book 
   TABLE DATA           ]   COPY public.hall_book (id, user_id, hall_id, date, day, month, year, code, hour) FROM stdin;
    public          reftreft    false    211   �W       h          0    74340    hall_book_dashboard 
   TABLE DATA           �   COPY public.hall_book_dashboard (id, user_id, hall_id, halluser_id, datefrom, dateto, hourfrom, hourto, date, type, amount, onehour) FROM stdin;
    public          reftreft    false    216   �\       e          0    74172    hallrate 
   TABLE DATA           <   COPY public.hallrate (hallid, userid, id, rate) FROM stdin;
    public          reftreft    false    213   �]       \          0    33692 
   migrations 
   TABLE DATA           6   COPY public.migrations (id, name, run_on) FROM stdin;
    public          reftreft    false    203   �]       `          0    57924    user_message 
   TABLE DATA           P   COPY public.user_message (id, name, phone, email, message, user_id) FROM stdin;
    public          reftreft    false    207   q^       ^          0    57906    users 
   TABLE DATA           �   COPY public.users (id, email, password, name, phone, city, role, profile_img, password_changed_at, password_verified_code, password_reset_expires, reset_code_verified) FROM stdin;
    public          reftreft    false    205   �^       u           0    0    hall_book_dashboard_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.hall_book_dashboard_id_seq', 24, true);
          public          reftreft    false    215            v           0    0    hall_book_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.hall_book_id_seq', 1120, true);
          public          reftreft    false    210            w           0    0    hall_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.hall_id_seq', 29, true);
          public          reftreft    false    208            x           0    0    hallrate_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.hallrate_id_seq', 160, true);
          public          reftreft    false    214            y           0    0    migrations_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.migrations_id_seq', 77, true);
          public          reftreft    false    202            z           0    0    user_message_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.user_message_id_seq', 3, true);
          public          reftreft    false    206            {           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 53, true);
          public          reftreft    false    204            �
           2606    74348 ,   hall_book_dashboard hall_book_dashboard_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.hall_book_dashboard
    ADD CONSTRAINT hall_book_dashboard_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.hall_book_dashboard DROP CONSTRAINT hall_book_dashboard_pkey;
       public            reftreft    false    216            �
           2606    57963    hall_book hall_book_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.hall_book
    ADD CONSTRAINT hall_book_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.hall_book DROP CONSTRAINT hall_book_pkey;
       public            reftreft    false    211            �
           2606    57949    hall hall_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.hall
    ADD CONSTRAINT hall_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.hall DROP CONSTRAINT hall_pkey;
       public            reftreft    false    209            �
           2606    33697    migrations migrations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
       public            reftreft    false    203            �
           2606    57932    user_message user_message_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.user_message
    ADD CONSTRAINT user_message_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.user_message DROP CONSTRAINT user_message_pkey;
       public            reftreft    false    207            �
           2606    57921    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            reftreft    false    205            �
           2606    57919    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            reftreft    false    205            �
           2606    57950    hall fk_hall__user    FK CONSTRAINT     �   ALTER TABLE ONLY public.hall
    ADD CONSTRAINT fk_hall__user FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 <   ALTER TABLE ONLY public.hall DROP CONSTRAINT fk_hall__user;
       public          reftreft    false    2763    209    205            �
           2606    74359    hall_book_dashboard fk_hall_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.hall_book_dashboard
    ADD CONSTRAINT fk_hall_id FOREIGN KEY (hall_id) REFERENCES public.hall(id) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.hall_book_dashboard DROP CONSTRAINT fk_hall_id;
       public          reftreft    false    216    2767    209            �
           2606    57974    hall_book fk_hall_id_book    FK CONSTRAINT     �   ALTER TABLE ONLY public.hall_book
    ADD CONSTRAINT fk_hall_id_book FOREIGN KEY (hall_id) REFERENCES public.hall(id) ON UPDATE CASCADE ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.hall_book DROP CONSTRAINT fk_hall_id_book;
       public          reftreft    false    209    211    2767            �
           2606    74354 "   hall_book_dashboard fk_halluser_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.hall_book_dashboard
    ADD CONSTRAINT fk_halluser_id FOREIGN KEY (halluser_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.hall_book_dashboard DROP CONSTRAINT fk_halluser_id;
       public          reftreft    false    2763    216    205            �
           2606    57964    hall_book fk_user_hall_book    FK CONSTRAINT     �   ALTER TABLE ONLY public.hall_book
    ADD CONSTRAINT fk_user_hall_book FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.hall_book DROP CONSTRAINT fk_user_hall_book;
       public          reftreft    false    2763    205    211            �
           2606    74349    hall_book_dashboard fk_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.hall_book_dashboard
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.hall_book_dashboard DROP CONSTRAINT fk_user_id;
       public          reftreft    false    216    205    2763            �
           2606    57933    user_message fk_user_message    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_message
    ADD CONSTRAINT fk_user_message FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.user_message DROP CONSTRAINT fk_user_message;
       public          reftreft    false    205    2763    207            �
           2606    74177    hallrate hallrate_hallid_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.hallrate
    ADD CONSTRAINT hallrate_hallid_fkey FOREIGN KEY (hallid) REFERENCES public.hall(id);
 G   ALTER TABLE ONLY public.hallrate DROP CONSTRAINT hallrate_hallid_fkey;
       public          reftreft    false    209    213    2767            �
           2606    74182    hallrate useridrate    FK CONSTRAINT     q   ALTER TABLE ONLY public.hallrate
    ADD CONSTRAINT useridrate FOREIGN KEY (userid) REFERENCES public.users(id);
 =   ALTER TABLE ONLY public.hallrate DROP CONSTRAINT useridrate;
       public          reftreft    false    2763    205    213            b   �  x��Wˎ�]���w#�Q�q�l�E֑��n�p���/bX����B��� ����79͇�M�FVA�!�a�Vw�󸧵�6�[ZvJw��|����_=~��o����6|���-mi=��c�������v��|�[~������g}��-���Q��6�&r�QΚ����
��1*���\v�7�8�[٬¯P墰>d��J�K�)Z)/�������K���Ă�$P�S7�}��W��/��E&�\m�z�UىlM�'��Vt-�e��ׇE�;�&�hUW��ŊllWf��T��଻FY�j^y%��ѱ/ذA�oi�~#4�6Pen�b�o�lgC�]����/6��vJ��w������ǯ�}��Au:���m� � �.����s��Z����/^�W���x����b�}z%���A~��OS�~tu�ř"�C\�(� �l@��"vS(���]���V�D'�Sv��Y����� K%,� ��ԫ)E������hqY�U"�V��Y;m&��D�3E�c-��"��JP���M(�|-`L��H.���iLP��-�#��7*�T�+�0�Hs�8�`N����Ĵ�XɃj4޿QqJ׭6P~�)��W�~����t�8��^o_����._u/�/���ǚ������#���oW����6����|Y�ʛ����MyG|hDP_󃆹��w�
N@�a�I*��Q �A
~���&�E��q)h�m�� �j5�)F� !x� `NQ�dt�yR�@�{�wg��dB�8Iձ�q@�֤B�HM�$���7'|��X�� r��@�F+@�#�D��%Y`z'm�2�@Vה(���
S�����f���@��u��h�ݬ>?N���8������Ed-)�PD�b5H.�*H��NWދ�+��Mz�2�"�~*�Q�Ȱ}%�%j�M�/H�*��4��d	�"*g�#Q����^O\��X��p�a`h-T�p([k�n� 8uI����F`'���|UB��i���W�qLS3��F���@��9�5���^3%������7�~I�| ���~���������7�_��"O��mg�M���~�I�V��a�[�3��2��f9h�8aj�M��(������Q�������ʄ0e�������_L�$BF�=�ഌX�ErXB�4�����T�0S���Dd�E���Q`nԣ$r��]�<�X�R�7`G�˦��zgқ���EX)�݆�g�(0�cX����ث)ƾ�;��v����|_�����'R�~����;ĉo�oO#����C�g����f۟��a8W�<o���lyI�F<T)�v`aXj�q�-� ��(ᨢ;���l�����`��scT�r�d�b(���#a�+�<L�tqv3���ukJ"��a�؊ �*f�V\3�%���z��	^�q@�AX-985!��SLH�s����1� ��M�@�j�p��P-O�8Yi\�]��F����y���A�?�p���ղ��G��Ϸ�����_��1��7�vF��w�n��~�¯_q�Z՞�t��9/�#��5;8b�?�=�L�[�+S|=�3I���xD�}t��1��
������u�sG�T-�ET;�F�A��� Fn��X?��BӚ	�$b-3>�6D<�@��ԸX��0g8RG���韋���辺_�Z�������Ϲ�@ay�hD�������3R��$�0#��Q�O{�;�'��
aY���|s�dNI��Gܽ�@&S��#� �Y[Db=\��P/�p[����d�1z������1����ڧQ��������3pl�}�?H��h��)�'53��FD�S4(QF�G���2Z�*L1� WՇx� R���*�� �4A��U;xj�8^��oL<l�4r�d�ϘU���t��څq�4^^?y����b-      d   �  x���Y��0D�=w�@�Μ%�?Gh�	TE6`��xc�,%��t�q�z��'���˞�~���߆L��)]�돎�y���z��F�o]�ވn�.�}!�#$ٿ?����~��BFN2W`sC��{r����d�pA����y�CД���!m�eA
o���AcAcC�Z� (I[P{�N%�*Q��DD��t��N���Ӎ���B�����N�j	��2	A�冄 �����"�3ii�wB���\y⚮���74�AXS'�XeA����!�G�tt.R� �H�T�[W��[3I_v+���l���H"�]�|�`5l�Qd����v��)Ȼ,lr�g��,{�,�����8� �,Tʂk�8� ���qb����zˉp��r���o��3h9/�}��N�{Slb���pl�b� ���8e0$�%L��fF��	���u�q����q>��CLE�2��߈i�4f,g���Lgf	����`f�b&2��5�Qd��=��)�[RM��e1��`~̽�'2��L����H&�U�@�he��@j��oF4�� ����ĽmA����[,H�Zh[`ļ&�U&�R"@)�M���@\C�X'��X�}�	��o�!�6������B`�/���� ��2�X�:A���� ����Ű�A� �Þo�"��g<�()BX{3��M+b�E�H�s� R��"� !��'�S���oj�8m���-O��g��)���t^������H,<��)<RyI���&�7ޅw���TݝK�Q����ȧ�:�7߅����w*OxԹ������Ʉ�߃@��)D�Z�a#��J*�0C���bbN���b�o��Rn��KC�`�KC�;T���ۋ��C�Iͥ,����C���/����dAi��0�!(mw���@p��]iCW�]�b�.88M>����[�/�ȟ�cND��7]x1�S���
쬒:�ŷfp����C/	��6���QŅ���J�U)6/��1k�Ny1�Pݼ�M�P]"b�P]"b���D�h��D��r*�9��>�ߜ����9S�!(mw�CP��?�/(mw��!XSw��!X�pk
�묒������5�?)p��n���&	��w��ª[Ql�xC���$tR��}��*:����F�A����KD���KyAʇ�XD������9�!o:ǋe�M׵1���N���M��C�a�����ٵ�zݯ�	�h�?�~~~���Q/      h   �   x���An!E��.T���9A6�Z)�Dj�Eo_CL'(�f�g������=�=n3ܮ���'�WD}���5�<MQ�³4��4Ǝ��%�|YR��x�m�X*6%t�hN�}����&>y�G�e���G>� ��An4з!� l@�@y��d]��.ԫ�T?���~p:i�a�q���6 W~Ǳ�d-����n;�H��v��;=Y�]e�C�c(Yh�W��. a����h����/��      e   N   x�%���0���
'�.����N28�pL�h;h��@Z��r�z��=۔��z�z˳}��A��rŀ�Q�3�aO�      \   w   x�m�A
�@��us
/�1y�Ll�� `������E�z������	$ԷQ���~�1pB��'�~�E��=�jk�v�Q���P˅�t�'�E��P��ۺ>���L�DD_��,�      `   J   x�3��/�M��4040�026�02��8�I���\�L��ļ�Ĕ��ĜO�2�T!#5�@!7��؈+F��� m�r      ^   �  x���ˎ�����Oу#e�EU��*Ej0�n���E����6F���� ��I�A^��ۤ�>�7�����Z|��_��"�'xO/�Er�[ZEmjᏆ�!&���c�²Dˢ(#D�C���*���w��_�,x�ǡ�x�� "E���L��Ѝ����)�/x����s���S����Z_�,m����������Ƌ�jE]s�U7�8���n*�DJ]�2a}}���ʈ�P�L%\���xiz������[od/�Oy|V���2��K�v1��z����6I�;���^wv��OXק ��2�X�l��y��+��� E
�(�"���+���2z@��G������W���o��es�T't��ze�Y����p�wC�s�o��3���>\/\EB���1��1!?�bXE )
��(�E��v��/�K�?�4�qY��js�n�u��i��k�M=���.�� L��9ٟ��u����\de� �ǅ�3�o�`>,Bw���'����~}Dm�� �O]�:�6�ǋ�>��s�/��t�L�<�}I.��%�Uy�=JY� �cT�*
a�tC�{��~����r�[�n.%��9.�S`�;k\v7�njQ�x�s�3M=iyӃ^�`*���U�.c�LPB��'���L��s��Mmm���n����NU_��NHE;�Wu�&�5,uX�S@��O)�$Y� +N�tC��Sw��fv���쎾lg�V���4M�cwWڇt�1��/��b�Uct.�$`�2B a$���#?�Lݷ@��F<k��w���J磑�}����
�h��+��k�/�c��7���7�u4��p�o���]�Z,C���-����n�6w��s��Ɍ6�Y���]sn��F�d����2UŬy'�jo�n�↟�FHL��X��%�������9���2���`L��4������E�O�C<<�'��|(�ɕO��j�$�G���B����G$����}C�=�� Ϊ��Ē�����Q�8OF�ݗ<#.χY���D-]a����"X���)�Ȍ��|w{�2���������6�����[�� ��Y�_��sT��~8��}\���9�%��D.c.�`�p!��cF��RD�X��i]'�3�ۉȷ���f *Ќ��eq[if>�`uhw/��!T�3����=	Kŧ
�?|���������z-�-Zi�s_:���?a��)Y�A��T^,���T�7�q��â)C��'��5��@JX!�(�������^��0*Z�l8�6�(V�%Ӭe�(���b<�ע�.<w��!��+���a���¹�W�R��c���������W7�Zm�HҸԎ�03��~IkY��s�S'w��n�K}09�0X���;X �,��X.�2-�$d~�=\/�x�zM�dm,���̬�S G��u2g�]$V]�2��g�֬a��!��q�J��ֆ�q 2A,�g|�x��lnO��3A�X>�L�ݾ�����F��c7��Ł%U�I�s<P�M��p�;
 �
%ʗ�q����L:�Dƨe�f3�g�}��\�x���K\�Ȑ�n�n�}]�X&2?���*�/����ud�^����XF��6�Cڌ'�r�hl�f2�TAn�R��y��w
��)Á�e� /C�Wǯ��b4����z�aE��p�n��U'�9>L��Lo`��s֝���7a8!�n�!E*i�:d�����_����?�J�H���*\YT)�I�e��+��Lm���S�e���>f�R7��av�����X2U�aG��[�����t=6ԫ�����/_�̯}���?h�;��A���PVh1�"���>\/��^��޺�I��[)��a� eXT��ۛ�Sǯ��Xӏ��&M����q�s���]�7��z�J�V�����xE�O�	��v�qt�tj-����8�J���d��LҚw�Ơ��Y���__}��yI.�ݬ��������Dʄ,QnRi����0ǯ�nuӰݼ4]��Ƹ�ݶ<�{s��jKf6+)�x�
��h�c�Y��#}
�=ɖp������b!ᰯX���QB�f�م������q��+澺Л}�D��%q��NO��I�G�-�Ld�cT�᧖̭(宙1\�E�$
ۇWy9�yh�I>#K����"�#i�jm�s9�G��דR����j�U���y�V��j��x�hY�vP��������/_�j㰹     