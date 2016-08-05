# Copyright 2016 Hewlett Packard Enterprise Development LP
 #
 # Licensed under the Apache License, Version 2.0 (the "License"); you may
 # not use this file except in compliance with the License. You may obtain
 # a copy of the License at
 #
 #      http://www.apache.org/licenses/LICENSE-2.0
 #
 # Unless required by applicable law or agreed to in writing, software
 # distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 # WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 # License for the specific language governing permissions and limitations
 # under the License.

import sys
from restobject import RestObject

def ex2_get_base_registry(restobj):
    sys.stdout.write("\nEXAMPLE 2: Find and return registry " + "\n")
    response = restobj.rest_get("/rest/v1/Registries")
    messages = {}

    identifier = None

    for entry in response.dict["Items"]:
        if "Id" in entry:
            identifier = entry["Id"]
        else:
            identifier = entry["Schema"].split(".")[0]

        if identifier not in ["Base", "iLO"]:
            continue

        for location in entry["Location"]:
            reg_resp = restobj.rest_get(location["Uri"]["extref"])

            if reg_resp.status == 200:
                sys.stdout.write("\tFound " + identifier + " at " + \
                                            location["Uri"]["extref"] + "\n")
                messages[identifier] = reg_resp.dict["Messages"]
            else:
                sys.stdout.write("\t" + identifier + " not found at "\
                                            + location["Uri"]["extref"] + "\n")

    return messages

if __name__ == "__main__":
    # When running on the server locally use the following commented values
    # iLO_host = "blobstore://."
    # iLO_account = "None"
    # iLO_password = "None"

    #accepts arguments when run
    try:
        iLO_host = "https://" +str(sys.argv[1])
        iLO_account = str(sys.argv[2])
        iLO_password = str(sys.argv[3])
        #Create a REST object
        REST_OBJ = RestObject(iLO_host, iLO_account, iLO_password)
        ex2_get_base_registry(REST_OBJ)

    except Exception:
        sys.stderr.write("Credentials Error \n")
