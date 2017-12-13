#!/bin/bash
#OTX-Python adding Alien Vault API
#CREATE AlienVault API script
echo "Enter AlienVault OTX API Key: "
read AV_OTX_API_KEY
sed -i "s/API_KEY = ''/API_KEY = '$AV_OTX_API_KEY'/" /scripts/OTX-Python-SDK/examples/cli_example.py \
/scripts/OTX-Python-SDK/examples/misp_json_to_otx.py \
/scripts/OTX-Python-SDK/examples/update_feed.py \
/scripts/OTX-Python-SDK/examples/update_pulse.py  \
/scripts/OTX-Python-SDK/examples/is_malicious/is_malicious.py
sed -i "s/OTXv2('API_KEY')/OTXv2('$AV_OTX_API_KEY')/" /scripts/OTX-Python-SDK/examples/get_yara_rules.py

#CREATE APIs for munin script
echo "Enter VirusTotal API Key: "
read VT_PUBLIC_API_KEY
echo "Enter MalShare API Key: "
read MAL_SHARE_API_KEY
echo "Enter Payload Security API Key: "
read PAYLOAD_SEC_API_KEY 
echo "Enter Payload Security Secret API Key: "
read PAYLOAD_SEC_API_SECRET

echo "[DEFAULT]
VT_PUBLIC_API_KEY = $VT_PUBLIC_API_KEY
MAL_SHARE_API_KEY = $MAL_SHARE_API_KEY
PAYLOAD_SEC_API_KEY = $PAYLOAD_SEC_API_KEY
PAYLOAD_SEC_API_SECRET = $PAYLOAD_SEC_API_SECRET" > /scripts/munin/munin.ini

#FileLookup VirusTotal API
sed -i 's/vt_key = ""/vt_key = "$VT_PUBLIC_API_KEY"/' /scripts/FileLookup/filelookup.py
#SSMA VirusTotal API
sed -i '36ivt_api = "$VT_PUBLIC_API_KEY"' /scripts/SSMA/ssma.py

#Signature-base
sed -i "s/OTX_KEY = ''/OTX_KEY = '$AV_OTX_API_KEY'/" /scripts/otx-iocs/get-otx-iocs.py

#Loki VT API
sed -i "s/API_KEY = '-'/API_KEY = '$VT_PUBLIC_API_KEY'/" /scripts/Loki/tools/vt-checker.py
sed -i "s/API_KEY = '-'/API_KEY = '$VT_PUBLIC_API_KEY'/" /scripts/Loki/tools/vt-checker-hosts.py


echo ""
echo "----------------------------------------------------------------------------------------"
echo "Updating Loki
echo "----------------------------------------------------------------------------------------"
echo ""
cd /scripts/Loki && python /scripts/Loki/loki.py --update