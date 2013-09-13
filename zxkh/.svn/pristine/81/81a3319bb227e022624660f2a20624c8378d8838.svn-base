package org.ptbank.func;

public class Crypt {

    public Crypt()
    {
    }

    public static synchronized String Encrypt(String s, String s1)
    {
        String s2 = new String(s.trim() + "Afds34DDas.,;kd45fjhg;654Ads5GGGG766767767gfdgfdgfd-55;A;hjhg.,<>dsd?????==dsjkljjklsdl5fdSfdff121dDDDDg-=-g55654gfdkkkkkk");
        String s3 = "1234Gwe90tfds34DAApd6f4Dr5678yuio7890fghjkl;[]zpa90tsd56x90tcvjkljjklsdl5fdSfdff121dDDDDg-=-g55654gfdkkkkkkbn90tsssgfgfgssssm,./";
        byte abyte0[] = s2.getBytes();
        byte abyte1[] = s1.getBytes();
        int i = abyte1.length;
        byte abyte2[] = new byte[i];
        byte abyte3[] = s3.getBytes();
        for(int j = 0; j < i; j++)
        {
            if(abyte0[j] < 0)
                abyte0[j] = (byte)(abyte0[j] + 128);
            if(abyte1[j] < 0)
                abyte1[j] = (byte)(abyte1[j] + 128);
            abyte2[j] = (byte)(abyte1[j] ^ abyte0[j] ^ abyte3[j]);
        }

        return new String(abyte2);
    }

    public static synchronized String Decrypt(String s, String s1)
    {
        String s2 = new String(s.trim() + "Afds34DDas.,;kd45fjhg;654Ads5GGGG766767767gfdgfdgfd-55;A;hjhg.,<>dsd?????==dsjkljjklsdl5fdSfdff121dDDDDg-=-g55654gfdkkkkkk");
        String s3 = "1234Gwe90tfds34DAApd6f4Dr5678yuio7890fghjkl;[]zpa90tsd56x90tcvjkljjklsdl5fdSfdff121dDDDDg-=-g55654gfdkkkkkkbn90tsssgfgfgssssm,./";
        byte abyte0[] = s1.getBytes();
        byte abyte1[] = s2.getBytes();
        int i = abyte0.length;
        byte abyte2[] = new byte[i];
        byte abyte3[] = s3.getBytes();
        for(int j = 0; j < i; j++)
        {
            if(abyte1[j] < 0)
                abyte1[j] = (byte)(abyte1[j] + 128);
            if(abyte0[j] < 0)
                abyte0[j] = (byte)(abyte0[j] + 128);
            abyte2[j] = (byte)(abyte0[j] ^ abyte1[j] ^ abyte3[j]);
        }

        return new String(abyte2);
    }

    public static String GrpEncrypt(String s, String s1)
    {
        String s2 = cal(s) + "djkaylajkldkPUaaioapQasaFHaaKpaklfsdJJaazlaaTfffffffffssdlrfQWasdfbnmzxczxccYUramyrahuoprweklNkfdsioprwekRrfsdlrrewrewkaylajkldkPUaaioapQasaFHaaKpaklfsdJJaazlaaTfffffffffssdlrfQWasdfbnmzxczxccYUramyrahuoprweklNkfdsioprwekRrfsdlrrewrewioprwekRrfsdlrrewrewwrewaaioapQasaFHaaKpaklfsdJJaazlaaTfffffffffssdlrfQWasdfbnmzxczxccYUramyrahuoprweklNkfdsioprwekRrfsdlrrewrewioprwekRrfsdlrrewrewwrewffffssdlrfQWasdfioprwekRrfsdrfsdasdfiopraaioapQasaFHaaKpaklfsdJJaazlaaTfffffffffssdlrfQWasdfrfQWasdf";
        byte abyte0[] = s1.getBytes();
        int i = abyte0.length;
        byte abyte1[] = new byte[i];
        byte abyte2[] = s2.getBytes();
        for(int j = 0; j < i; j++)
            abyte1[j] = (byte)(abyte0[j] ^ abyte2[j]);

        return new String(abyte1);
    }

    public static String GrpDecrypt(String s, String s1)
    {
        String s2 = cal(s) + "djkaylajkldkPUaaioapQasaFHaaKpaklfsdJJaazlaaTfffffffffssdlrfQWasdfbnmzxczxccYUramyrahuoprweklNkfdsioprwekRrfsdlrrewrewkaylajkldkPUaaioapQasaFHaaKpaklfsdJJaazlaaTfffffffffssdlrfQWasdfbnmzxczxccYUramyrahuoprweklNkfdsioprwekRrfsdlrrewrewioprwekRrfsdlrrewrewwrewaaioapQasaFHaaKpaklfsdJJaazlaaTfffffffffssdlrfQWasdfbnmzxczxccYUramyrahuoprweklNkfdsioprwekRrfsdlrrewrewioprwekRrfsdlrrewrewwrewffffssdlrfQWasdfioprwekRrfsdrfsdasdfiopraaioapQasaFHaaKpaklfsdJJaazlaaTfffffffffssdlrfQWasdfrfQWasdf";
        byte abyte0[] = s1.getBytes();
        int i = abyte0.length;
        byte abyte1[] = new byte[i];
        byte abyte2[] = s2.getBytes();
        for(int j = 0; j < i; j++)
            abyte1[j] = (byte)(abyte0[j] ^ abyte2[j]);

        return new String(abyte1);
    }

    public static String cal(String s)
    {
        byte abyte0[] = s.getBytes();
        for(int i = 0; i < abyte0.length; i++)
            abyte0[i] = (byte)(abyte0[i] + 50);

        return new String(abyte0);
    }

    public static String byte2hex(byte abyte0[])
    {
        String s = "";
        for(int i = 0; i < abyte0.length; i++)
        {
            String s2 = Integer.toHexString(abyte0[i] & 0xff);
            if(s2.length() == 1)
                s = s + "0" + s2;
            else
                s = s + s2;
            if(i < abyte0.length - 1)
                s = s + ":";
        }

        return s.toUpperCase();
    }
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO 自动生成方法存根
		String s2 = Crypt.Encrypt("10000000", "111111");
		System.out.println(s2);

	}

}
